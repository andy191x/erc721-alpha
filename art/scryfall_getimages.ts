#!/usr/bin/env ts-node

//
// Loads a scryfall json data blob (generated by scryfall_get) and downloads all of the images to a target folder.
// The target folder must not already exist.
//

import * as path from 'path';
import axios, {AxiosResponse, ResponseType} from 'axios';
import fs from 'fs';

//
// Methods
//

const main = async () => {

    let jsonFile = '';
    let targetFolder = '';
    let size = '';

    if (process.argv.length >= 3) {
        jsonFile = process.argv[2];
    }
    if (process.argv.length >= 4) {
        targetFolder = process.argv[3];
    }
    if (process.argv.length >= 5) {
        size = process.argv[4];
    }

    if (jsonFile.length == 0)
    {
        l('Usage: ' + usage());
        l_error('Invalid JSON_FILE.');
        return 1;
    }
    if (targetFolder.length < 2)
    {
        l('Usage: ' + usage());
        l_error('Invalid TARGET_FOLDER.');
        return 1;
    }
    if (size.length == 0)
    {
        l('Usage: ' + usage());
        l_error('Invalid SIZE.');
        return 1;
    }

    // Load data
    l('Loading JSON file...');

    let data: any = {};

    try {
        let json = fs.readFileSync(jsonFile, {encoding: <BufferEncoding>'utf-8'});

        data = JSON.parse(json);
        if (data == null) {
            l_error('Invalid JSON data.');
            return 1;
        }

        if (!data.hasOwnProperty('set') || !data.hasOwnProperty('card_array')) {
            l_error('Invalid JSON data format.');
            return 1;
        }
    }
    catch (e) {
        l_error('Cannot load JSON file.');
        return 1;
    }

    // Make folder
    l('Creating folder...');

    let folder = targetFolder + '/' + size;
    folder = folder.replace('\\', '/');
    folder = folder.replace('//', '/');

    try {
        if (fs.existsSync(folder)) {
            l_error('Target folder already exists (' + folder + ').');
            return 1;
        }

        fs.mkdirSync(folder, {recursive: true});

        if (!fs.existsSync(folder)) {
            l_error('Cannot create target folder (' + folder + ').');
            return 1;
        }
    }
    catch (e) {
        l_error('Folder creation error.');
        return 1;
    }

    // Download cards
    l('Downloading images...');

    for (let i = 0; i < data.card_array.length; i++) {
        let card = data.card_array[i];
        let multiverseId: number = card.multiverse_ids[0];

        l(card.name + ' (' + multiverseId + ') ...');

        let imageURL = '';
        let ext = '';

        if (card.image_uris.hasOwnProperty(size)) {
            imageURL = card.image_uris[size];
        }

        if (imageURL.match(/^http/i) === null) {
            l_error('No matching download URL.');
            return 1;
        }

        if (imageURL.match(/.jpg/) !== null) {
            ext = '.jpg';
        }
        else if (imageURL.match(/.png/) !== null) {
            ext = '.png';
        }
        else {
            l_error('Unsupported image format.');
            return 1;
        }

        let file = folder + '/' + multiverseId + ext;
        try {
            fs.unlinkSync(file);
        }
        catch (e) {
            // ...
        }

        let downloadResult = await scryfallImageDownload(imageURL, file);
        if (!downloadResult.ok) {
            l_error('Download failed: ' + downloadResult.error);
        }
    }

    l('done.');
    return 0;
}

const usage = () => {
    return path.basename(__filename) + ' <JSON_FILE> <TARGET_FOLDER> [SIZE]';
}

const l = (text: string) => {
    console.log(text);
}

const l_error = (text: string) => {
    console.log('ERROR: ' + text);
}

const scryfallImageDownload = async (url: string, file: string, timeout_ms = 15000): Promise<{ ok: boolean, error: string }> => {
    let result = { ok: false, error: 'Unknown error.' };

    // Send request, pipe data to file
    try {
        let config = {
            timeout: timeout_ms,
            responseType: <ResponseType>'stream'
        };
        let response = await axios.get(url, config);
        response.data.pipe(fs.createWriteStream(file));
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

