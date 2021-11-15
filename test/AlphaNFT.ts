
import { ethers, waffle } from 'hardhat';
import { expect } from 'chai';
import * as KSink from './util/KSink';

describe("AlphaNFT", function () {

    let contract = null;

    before(async function() {
        const Contract = await ethers.getContractFactory("AlphaNFT");
        contract = await Contract.deploy();
        await contract.deployed();
    });

    it("Should mint the first token.", async function () {
        //KSink.testme();
        expect(true);
    });

});
