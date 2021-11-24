#!/usr/bin/env ts-node

//
// Loads and aggregates the scryfall.com JSON for a given setname.
//

import * as path from 'path';
import axios, {AxiosResponse, ResponseType} from 'axios';

//
// Methods
//

const main = async () => {

    let setcode = '';
    if (process.argv.length >= 3) {
        setcode = process.argv[2];
    }

    if (setcode.length < 3) {
        console.log(errorJSON('Invalid SETCODE. Usage: ' + usage()));
        return 1;
    }

    // Poll set object from scryfall
    // from: https://scryfall.com/docs/api/sets
    // https://api.scryfall.com/sets/lea
    let url = 'https://api.scryfall.com/sets/' + setcode.toLowerCase();
    let scryfallResult = await scryfallJSONGET(url);
    let scryfallSet = scryfallResult.data;
    if (!scryfallResult.ok) {
        console.log(errorJSON('Cannot poll set data: ' + scryfallResult.error));
        return 1;
    }
    //console.log(scryfallSet);

    let nextPageURL = scryfallSet.hasOwnProperty('search_uri') ? scryfallSet.search_uri : '';
    let nextPageIndex = 0;
    let more = true;

    if (nextPageURL.match(/^http/i) === null) {
        console.log(errorJSON('Card search URL missing from set data.'));
        return 1;
    }

    // Poll card pages from scryfall
    let cardArray: any[] = [];

    while (more)
    {
        let scryfallResult = await scryfallJSONGET(nextPageURL);
        let scryfallCardPage = scryfallResult.data;
        if (!scryfallResult.ok) {
            console.log(errorJSON('Cannot poll page ' + nextPageIndex + ': ' + scryfallResult.error));
            return 1;
        }

        if (!scryfallCardPage.hasOwnProperty('has_more')) {
            console.log(errorJSON('Invalid JSON format (1) on page ' + nextPageIndex + ': ' + scryfallResult.error));
            return 1;
        }

        if (scryfallCardPage.hasOwnProperty('data') && Array.isArray(scryfallCardPage.data)) {
            cardArray = cardArray.concat(scryfallCardPage.data);
        }

        more = scryfallCardPage.has_more;
        if (more) {
            nextPageURL = scryfallCardPage.hasOwnProperty('next_page') ? scryfallCardPage.next_page : '';
            nextPageIndex++;
            if (nextPageURL.match(/^http/i) === null) {
                console.log(errorJSON('Next card search URL missing on page: ' + (nextPageIndex - 1)));
                return 1;
            }
        }

        if (nextPageIndex == 100)
        {
            console.log(errorJSON('Too many paging iterations. Is everything alright?'));
            return 1;
        }
    }

    // Generate new doc
    let doc: any = {};
    doc.set = scryfallSet;
    doc.card_array = cardArray;

    console.log(JSON.stringify(doc));

    return 0;
}

const usage = () => {
    return path.basename(__filename) + ' <SETCODE>';
}

const errorJSON = (text: string): string => {
    let data = { error: '' };
    data.error = text;
    return JSON.stringify(data);
}

const scryfallJSONGET = async (url: string, timeout_ms = 15000): Promise<{ ok: boolean, error: string, data: any }> => {

    let result = { ok: false, error: 'Unknown error.', data: {} };

    // Send request
    let response: AxiosResponse|null = null;

    try {
        let config = {
            timeout: timeout_ms,
            responseType: <ResponseType>'text'
        };
        response = await axios.get(url, config);
    } catch (e: any) {
        result.error = 'Web request failed: ' + e.toString()
        return result;
    }

    // Respect scryfall's rate limits
    await new Promise(resolve => {
        setTimeout(() => {
            resolve('resolved');
        }, 150);
    });

    //console.log(response);

    // Parse response data
    if (response === null) {
        result.error = 'Invalid response format.';
        return result;
    }

    if (response.data === null || typeof(response.data) != 'object') {
        result.error = 'Invalid JSON response.';
        return result;
    }

    result.ok = true;
    result.data = response.data;

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

