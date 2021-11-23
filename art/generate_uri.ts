#!/usr/bin/env node

//
// Methods
//

let main = async () => {
    //console.log('TODO: FINISH ME');

    for (let i = 0; i < 295; i++) {
        console.log('_defaultURI[' + i + '] = \'01234567890123456789012345678901234567\';');
    }

    return 0;
}

//
// Script logic
//

main().then(retCode => {
    process.exitCode = retCode;
})
.catch((e) => {
    console.log('Caught exception from main():');
    throw e
});
