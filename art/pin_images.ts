#!/usr/bin/env ts-node

//
// Transfers downloaded scryfall images to pinata and generates a mapping object with the pinned IPFS urls.
// Images must have been previously obtained with "scryfall_getimages.ts".
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
    return path.basename(__filename) + ' <IMAGE_DICTIONARY_JSON> <IMAGE_FOLDER> <PINATA_API_KEY> <PINATA_API_SECRET>';
}

const main = async () => {

    let imageDictionaryFile = '';
    let imageFolder = '';
    let pinataAPIKey = '';
    let pinataAPISecret = '';

    if (process.argv.length >= 3) {
        imageDictionaryFile = process.argv[2];
    }
    if (process.argv.length >= 4) {
        imageFolder = process.argv[3];
    }
    if (process.argv.length >= 5) {
        pinataAPIKey = process.argv[4];
    }
    if (process.argv.length >= 6) {
        pinataAPISecret = process.argv[5];
    }

    if (imageDictionaryFile.length == 0) {
        l('Usage: ' + usage());
        l_error('Invalid IMAGE_DICTIONARY_JSON.');
        return 1;
    }
    if (imageFolder.length < 2) {
        l('Usage: ' + usage());
        l_error('Invalid IMAGE_FOLDER.');
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

    // Load dictionary
    let imageDictionary: any = {};

    l('Loading dictionary...');
    try {
        if (fs.existsSync(imageDictionaryFile)) {
            let json = fs.readFileSync(imageDictionaryFile, {encoding: <BufferEncoding>'utf-8'});
            imageDictionary = JSON.parse(json);
            if (imageDictionary == null) {
                l_error('Invalid dictionary.');
                return 1;
            }
        }
    }
    catch (e) {
        l_error('Cannot load existing dictionary.');
        return 1;
    }

    // Discover images
    l('Discovering images...');

    let imageArray: any = [];
    try {
        fs.readdirSync(imageFolder).forEach(file => {
            let image = imageFolder + '/' + file;
            image.replace('\\', '/');
            image.replace('//', '/');

            let multiverseId = imageFileToMultiverseId(image);
            if (multiverseId > 0) {
                imageArray.push(image);
            }
        });
    }
    catch (e) {
        l_error('Cannot discover images.');
        return 1;
    }

    imageArray.sort((a: any, b: any) => {
        let ax = imageFileToMultiverseId(a);
        let bx = imageFileToMultiverseId(b);

        if (ax == bx) {
            return 0;
        }

        return ax < bx ? -1 : 1;
    });

    l('Discovered ' + imageArray.length + ' images.');

    // Upload and pin images
    let pinataClient = pinata.default(pinataAPIKey, pinataAPISecret);

    for (let i = 0; i < imageArray.length; i++) {
        let multiverseId = imageFileToMultiverseId(imageArray[i]);
        let multiverseIdStr = multiverseId.toString();
        l('Processing: ' + multiverseId);

        if (imageDictionary.hasOwnProperty(multiverseIdStr)) {
            l(' - already pinned');
            continue;
        }
        else {
            // Pin file
            l(' - pinning...');

            let pinResult = await pinataPinFile(pinataClient, imageArray[i], 'alpha_' + multiverseIdStr);

            if (pinResult.ok) {
                l(' - pinned: ' + pinResult.ipfsURL);
                imageDictionary[multiverseIdStr] = pinResult.ipfsURL;
            }
            else {
                l_error(' - pin failed: ' + pinResult.error);
            }

            // Respect pinata's rate limits
            await new Promise(resolve => {
                setTimeout(() => {
                    resolve('resolved');
                }, 3000);
            });
        }
    }

    // Save dictionary
    l('Saving dictionary...');
    try {
        let json = JSON.stringify(imageDictionary);
        fs.writeFileSync(imageDictionaryFile, json, {encoding: <BufferEncoding>'utf-8'});
    }
    catch (e) {
        l_error('Cannot save dictionary');
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

const pinataPinFile = async (pinataClient: PinataClient, file: string, pinataMetadataName: string): Promise<{ ok: boolean, error: string, ipfsURL: string }> => {
    let result = { ok: false, error: 'Unknown error.', ipfsURL: '' };

    try {
        const readableStreamForFile = fs.createReadStream(file);
        const options: PinataPinOptions = {
            pinataMetadata: {
                name: pinataMetadataName
            },
            pinataOptions: {
                cidVersion: 0
            }
        };

        let pinataResult = await pinataClient.pinFileToIPFS(readableStreamForFile, options);
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

