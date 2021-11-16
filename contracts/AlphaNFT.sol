// Contract based on https://docs.openzeppelin.com/contracts/3.x/erc721
// SPDX-License-Identifier: MIT

pragma solidity ^0.7.3;

import "hardhat/console.sol";

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract AlphaNFT is ERC721, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    uint256 private constant LAST_ID = 295; // 295 pieces in the alpha set

    //
    // Methods
    //

    constructor() ERC721("AlphaNFT", "ALPHA")
    {
        // Start with ID #1.
        _tokenIds.increment();
    }

    function mint(address recipient, string memory tokenURI)
        public onlyOwner
        returns (uint256)
    {
        // Verify supply
        uint256 nextId = _tokenIds.current();
        if (nextId > LAST_ID)
        {
            revert("Sold out.");
        }
        _tokenIds.increment();

        // Mint
        uint256 newItemId = _tokenIds.current();
        _mint(recipient, newItemId);
        _setTokenURI(newItemId, tokenURI);

        return newItemId;
    }

    // ...
}
