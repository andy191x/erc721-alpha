
import { ethers, waffle } from 'hardhat';
import { expect } from 'chai';
import { Signer } from 'ethers';
import * as KSink from './util/KSink';

describe("AlphaNFT", function () {

    let contract: any;
    let wallet: Signer;
    let walletAddress: string;

    const LAST_ID = 295;

    before(async function() {
        const accounts = await ethers.getSigners();
        wallet = accounts[0];
        walletAddress = (await wallet.getAddress());

        const Contract = await ethers.getContractFactory("AlphaNFT", wallet);
        contract = await Contract.deploy();
        await contract.deployed();
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

    it("Should revert when minting from another wallet", async function () {
        const accounts = await ethers.getSigners();
        let wallet2 = accounts[1];
        let walletAddress2 = (await wallet2.getAddress());
        let contract2 = contract.connect(wallet2);

        await expect(
            KSink.waitWriteMethod(contract2.mint(walletAddress2, 'https://191x.com/token/9999'))
        ).to.be.revertedWith('Ownable: caller is not the owner');
    });

    it("Should revert when minting to address zero", async function () {
        await expect(
            KSink.waitWriteMethod(contract.mint(ethers.constants.AddressZero, 'https://191x.com/token/zero'))
        ).to.be.revertedWith('ERC721: mint to the zero address');
    });

    it("Should mint the remaining tokens", async function () {
        for (let i = 2; i <= LAST_ID; i++)
        {
            (await KSink.waitWriteMethod(contract.mint(walletAddress, 'https://191x.com/token/' + i)));
        }

        let totalSupply = (await contract.totalSupply()).toNumber();
        expect(totalSupply).to.equal(LAST_ID);
    });


    it("Should revert when minting beyond the total supply", async function () {
        await expect(
            KSink.waitWriteMethod(contract.mint(walletAddress, 'https://191x.com/token/9999'))
        ).to.be.revertedWith('Sold out.');
    });

    it("Should verify token IDs", async function () {
        for (let i = 0; i < LAST_ID; i++)
        {
            let token = (await contract.tokenByIndex(i)).toNumber();
            expect(token).to.equal(i + 1);
        }
    });

    // ...
});
