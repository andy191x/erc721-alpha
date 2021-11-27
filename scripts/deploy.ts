
import * as hre from 'hardhat';

//
// Methods
//

async function main() {
    let contractName = 'AlphaNFT';
    const contractFactory = await hre.ethers.getContractFactory(contractName);

    console.log('Deploying contract...');

    const contract = await contractFactory.deploy();
    await contract.deployed();

    console.log('Contract deployed to: ', contract.address);

    return 0;
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
