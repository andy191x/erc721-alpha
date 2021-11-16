
import { ethers, waffle } from 'hardhat';
import { expect } from 'chai';
import { Signer } from 'ethers';
import * as KSink from './util/KSink';

describe("AlphaNFT", function () {

    let contract: any;
    let wallet: Signer;
    let walletAddress: string;

    before(async function() {
        const Contract = await ethers.getContractFactory("AlphaNFT");
        contract = await Contract.deploy();
        await contract.deployed();

        const accounts = await ethers.getSigners();
        wallet = accounts[0];
        walletAddress = (await wallet.getAddress());
    });

    it("Should verify that no tokens have been minted", async function () {
        let totalSupply = (await contract.totalSupply()).toNumber();
        expect(totalSupply).to.equal(0);
    });

    it("Should mint the first token", async function () {

        (await KSink.waitWriteMethod(contract.mint(walletAddress, 'https://191x.com/token/1')));

        let totalSupply = (await contract.totalSupply()).toNumber();
        expect(totalSupply).to.equal(1);

        let walletBalance = (await contract.balanceOf(walletAddress)).toNumber();
        expect(walletBalance).to.equal(1);
    });
    

    // ...
});
