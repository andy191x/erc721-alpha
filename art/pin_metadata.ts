#!/usr/bin/env ts-node

//
// Generates and pins NFT metadata.
// Images must have been previously pinned with "pin_images.ts".
//

import * as path from 'path';
import axios, {AxiosResponse, ResponseType} from 'axios';
import fs from 'fs';
import * as pinata from '@pinata/sdk';
import pinataClient, {PinataClient, PinataPinOptions} from "@pinata/sdk";

//
// Methods
//

const usage = () => {
    return path.basename(__filename) + ' <SCRYFALL_SET_JSON> <IMAGE_DICTIONARY_JSON> <METADATA_DICTIONARY_JSON> <PINATA_API_KEY> <PINATA_API_SECRET>';
}

const main = async () => {

    let scryfallSetFile = '';
    let imageDictionaryFile = '';
    let metadataDictionaryFile = '';
    let pinataAPIKey = '';
    let pinataAPISecret = '';

    if (process.argv.length >= 7) {
        scryfallSetFile = process.argv[2];
        imageDictionaryFile = process.argv[3];
        metadataDictionaryFile = process.argv[4];
        pinataAPIKey = process.argv[5];
        pinataAPISecret = process.argv[6];
    }
    else {
        l('Usage: ' + usage());
        l_error('Not enough arguments.');
        return 1;
    }

    if (imageDictionaryFile.length == 0) {
        l('Usage: ' + usage());
        l_error('Invalid IMAGE_DICTIONARY_JSON.');
        return 1;
    }
    if (metadataDictionaryFile.length == 0) {
        l('Usage: ' + usage());
        l_error('Invalid METADATA_DICTIONARY_JSON.');
        return 1;
    }
    if (pinataAPIKey.length == 0) {
        l('Usage: ' + usage());
        l_error('Invalid PINATA_API_KEY.');
        return 1;
    }
    if (pinataAPISecret.length == 0) {
        l('Usage: ' + usage());
        l_error('Invalid PINATA_API_SECRET.');
        return 1;
    }

    // Load scryfall set, index by multiverse id
    let cardDictionary: any = {};

    l('Loading scryfall set...');
    try {
        let json = fs.readFileSync(scryfallSetFile, {encoding: <BufferEncoding>'utf-8'});
        let scryfallSet = JSON.parse(json);
        if (scryfallSet == null || !scryfallSet.hasOwnProperty('card_array')) {
            l_error('Invalid scryfall set.');
            return 1;
        }

        for (let i = 0; i < scryfallSet.card_array.length; i++) {
            let card: any = scryfallSet.card_array[i];
            let multiverseIdStr: string = card.multiverse_ids[0].toString();
            cardDictionary[multiverseIdStr] = card;
        }
    }
    catch (e) {
        l_error('Cannot load image dictionary.');
        return 1;
    }

    // Load image dictionary
    let imageDictionary: any = {};

    l('Loading image dictionary...');
    try {
        let json = fs.readFileSync(imageDictionaryFile, {encoding: <BufferEncoding>'utf-8'});
        imageDictionary = JSON.parse(json);
        if (imageDictionary == null || imageDictionary.length == 0) {
            l_error('Invalid dictionary.');
            return 1;
        }
    }
    catch (e) {
        l_error('Cannot load image dictionary.');
        return 1;
    }

    // Load metadata dictionary
    let metadataDictionary: any = {};

    l('Loading metadata dictionary...');
    try {
        if (fs.existsSync(metadataDictionaryFile)) {
            let json = fs.readFileSync(metadataDictionaryFile, {encoding: <BufferEncoding>'utf-8'});
            metadataDictionary = JSON.parse(json);
            if (metadataDictionary == null) {
                l_error('Invalid dictionary.');
                return 1;
            }
        }
    }
    catch (e) {
        l_error('Cannot load metadata dictionary.');
        return 1;
    }

    // Generate, upload, and pin metadata
    let pinataClient = pinata.default(pinataAPIKey, pinataAPISecret);

    for (const [multiverseIdStr, imageIPFSUrl] of Object.entries(imageDictionary)) {
        l('Processing: ' + multiverseIdStr);

        if (metadataDictionary.hasOwnProperty(multiverseIdStr)) {
            l(' - already pinned');
            continue;
        }
        else {
            // Pin file
            l(' - pinning...');

            if (!cardDictionary.hasOwnProperty(multiverseIdStr)) {
                l_error(' - pin failed: cannot lookup matching card!');
                continue;
            }

            let card: any = cardDictionary[multiverseIdStr];

            let metadata = {
                name: card.name,
                description: card.oracle_text,
                image: imageIPFSUrl
            };
            //console.log(metadata);

            let pinResult = await pinataPinJSON(pinataClient, metadata, 'alpha_metadata_' + multiverseIdStr);
            await new Promise(resolve => {
                // Respect pinata's rate limits
                setTimeout(() => {
                    resolve('resolved');
                }, 3000);
            });

            if (pinResult.ok) {
                l(' - pinned: ' + pinResult.ipfsURL);
                metadataDictionary[multiverseIdStr] = pinResult.ipfsURL;
            }
            else {
                l_error(' - pin failed: ' + pinResult.error);
                continue;
            }
        }
    }

    // Save dictionary
    l('Saving metadata dictionary...');
    try {
        let json = JSON.stringify(metadataDictionary);
        fs.writeFileSync(metadataDictionaryFile, json, {encoding: <BufferEncoding>'utf-8'});
    }
    catch (e) {
        l_error('Cannot save metadata dictionary');
        return 1;
    }

    // Success
    l('done.');
    return 0;
}

const l = (text: string) => {
    console.log(text);
}

const l_error = (text: string) => {
    console.log('ERROR: ' + text);
}

const imageFileToMultiverseId = (file: string): number => {
    const matches = file.match(/\d+\./);

    if (matches !== null) {
        return parseInt(matches[0]);
    }

    return 0;
}

const pinataPinJSON = async (pinataClient: PinataClient, jsonBody: object, pinataMetadataName: string): Promise<{ ok: boolean, error: string, ipfsURL: string }> => {
    let result = { ok: false, error: 'Unknown error.', ipfsURL: '' };

    try {
        const options: PinataPinOptions = {
            pinataMetadata: {
                name: pinataMetadataName
            },
            pinataOptions: {
                cidVersion: 0
            }
        };

        let pinataResult = await pinataClient.pinJSONToIPFS(jsonBody, options);
        result.ipfsURL = 'ipfs://' + pinataResult.IpfsHash;
    }
    catch (e: any) {
        result.error = e.toString();
        return result;
    }

    // Success
    result.ok = true;
    return result;
}

//
// Script logic
//

main().then(exitCode => {
    process.exitCode = exitCode;
})
.catch((e) => {
    console.log('Caught exception from main():');
    throw e
});

