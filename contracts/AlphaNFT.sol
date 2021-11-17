// Contract based on https://docs.openzeppelin.com/contracts/3.x/erc721
// SPDX-License-Identifier: MIT

pragma solidity ^0.7.3;

import "hardhat/console.sol";

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract AlphaNFT is ERC721, Ownable {

    uint256 private constant FIRST_ID = 1;
    uint256 private constant LAST_ID = 295; // 295 pieces in the alpha set

    using Counters for Counters.Counter;

    //
    // Private data
    //

    Counters.Counter private _tokenIds;
    mapping (uint256 => string) private _defaultURI;

    //
    // External methods
    //

    constructor() ERC721("AlphaNFT", "ALPHA")
    {
        // Start with Id #1.
        _tokenIds.increment();

        // Setup content
        _setBaseURI('https://191x.com/alphanft/'); // TODO: FINAL URL
        registerDefaultURI();
    }

    function mint(address recipient) external returns (uint256)
    {
        // Verify supply
        uint256 newItemId = _tokenIds.current();
        if (newItemId > LAST_ID) {
            revert("Sold out.");
        }
        _tokenIds.increment();

        // Mint
        _mint(recipient, newItemId);
        _setTokenURI(newItemId, _defaultURI[newItemId]);

        return newItemId;
    }

    //
    // Owner methods
    //

    function setBaseURI(string memory baseURI) external onlyOwner
    {
        _setBaseURI(baseURI);
    }

    function setTokenURI(uint256 tokenId, string memory tokenURI) external onlyOwner
    {
        if (!isTokenInRange(tokenId) || !isTokenMinted(tokenId)) {
            revert("Invalid token.");
        }
        _setTokenURI(tokenId, tokenURI);
    }

    //
    // Private methods
    //

    function isTokenInRange(uint256 tokenId) private pure returns (bool)
    {
        return (tokenId >= FIRST_ID && tokenId <= LAST_ID);
    }

    function isTokenMinted(uint256 tokenId) private view returns (bool)
    {
        return tokenId < _tokenIds.current();
    }

    function registerDefaultURI() private
    {
        // TODO: FINAL IDS

        _defaultURI[1] = '01234567890123456789012345678901234567';
        _defaultURI[2] = '01234567890123456789012345678901234567';
        _defaultURI[3] = '01234567890123456789012345678901234567';
        _defaultURI[4] = '01234567890123456789012345678901234567';
        _defaultURI[5] = '01234567890123456789012345678901234567';
        _defaultURI[6] = '01234567890123456789012345678901234567';
        _defaultURI[7] = '01234567890123456789012345678901234567';
        _defaultURI[8] = '01234567890123456789012345678901234567';
        _defaultURI[9] = '01234567890123456789012345678901234567';
        _defaultURI[10] = '01234567890123456789012345678901234567';
        _defaultURI[11] = '01234567890123456789012345678901234567';
        _defaultURI[12] = '01234567890123456789012345678901234567';
        _defaultURI[13] = '01234567890123456789012345678901234567';
        _defaultURI[14] = '01234567890123456789012345678901234567';
        _defaultURI[15] = '01234567890123456789012345678901234567';
        _defaultURI[16] = '01234567890123456789012345678901234567';
        _defaultURI[17] = '01234567890123456789012345678901234567';
        _defaultURI[18] = '01234567890123456789012345678901234567';
        _defaultURI[19] = '01234567890123456789012345678901234567';
        _defaultURI[20] = '01234567890123456789012345678901234567';
        _defaultURI[21] = '01234567890123456789012345678901234567';
        _defaultURI[22] = '01234567890123456789012345678901234567';
        _defaultURI[23] = '01234567890123456789012345678901234567';
        _defaultURI[24] = '01234567890123456789012345678901234567';
        _defaultURI[25] = '01234567890123456789012345678901234567';
        _defaultURI[26] = '01234567890123456789012345678901234567';
        _defaultURI[27] = '01234567890123456789012345678901234567';
        _defaultURI[28] = '01234567890123456789012345678901234567';
        _defaultURI[29] = '01234567890123456789012345678901234567';
        _defaultURI[30] = '01234567890123456789012345678901234567';
        _defaultURI[31] = '01234567890123456789012345678901234567';
        _defaultURI[32] = '01234567890123456789012345678901234567';
        _defaultURI[33] = '01234567890123456789012345678901234567';
        _defaultURI[34] = '01234567890123456789012345678901234567';
        _defaultURI[35] = '01234567890123456789012345678901234567';
        _defaultURI[36] = '01234567890123456789012345678901234567';
        _defaultURI[37] = '01234567890123456789012345678901234567';
        _defaultURI[38] = '01234567890123456789012345678901234567';
        _defaultURI[39] = '01234567890123456789012345678901234567';
        _defaultURI[40] = '01234567890123456789012345678901234567';
        _defaultURI[41] = '01234567890123456789012345678901234567';
        _defaultURI[42] = '01234567890123456789012345678901234567';
        _defaultURI[43] = '01234567890123456789012345678901234567';
        _defaultURI[44] = '01234567890123456789012345678901234567';
        _defaultURI[45] = '01234567890123456789012345678901234567';
        _defaultURI[46] = '01234567890123456789012345678901234567';
        _defaultURI[47] = '01234567890123456789012345678901234567';
        _defaultURI[48] = '01234567890123456789012345678901234567';
        _defaultURI[49] = '01234567890123456789012345678901234567';
        _defaultURI[50] = '01234567890123456789012345678901234567';
        _defaultURI[51] = '01234567890123456789012345678901234567';
        _defaultURI[52] = '01234567890123456789012345678901234567';
        _defaultURI[53] = '01234567890123456789012345678901234567';
        _defaultURI[54] = '01234567890123456789012345678901234567';
        _defaultURI[55] = '01234567890123456789012345678901234567';
        _defaultURI[56] = '01234567890123456789012345678901234567';
        _defaultURI[57] = '01234567890123456789012345678901234567';
        _defaultURI[58] = '01234567890123456789012345678901234567';
        _defaultURI[59] = '01234567890123456789012345678901234567';
        _defaultURI[60] = '01234567890123456789012345678901234567';
        _defaultURI[61] = '01234567890123456789012345678901234567';
        _defaultURI[62] = '01234567890123456789012345678901234567';
        _defaultURI[63] = '01234567890123456789012345678901234567';
        _defaultURI[64] = '01234567890123456789012345678901234567';
        _defaultURI[65] = '01234567890123456789012345678901234567';
        _defaultURI[66] = '01234567890123456789012345678901234567';
        _defaultURI[67] = '01234567890123456789012345678901234567';
        _defaultURI[68] = '01234567890123456789012345678901234567';
        _defaultURI[69] = '01234567890123456789012345678901234567';
        _defaultURI[70] = '01234567890123456789012345678901234567';
        _defaultURI[71] = '01234567890123456789012345678901234567';
        _defaultURI[72] = '01234567890123456789012345678901234567';
        _defaultURI[73] = '01234567890123456789012345678901234567';
        _defaultURI[74] = '01234567890123456789012345678901234567';
        _defaultURI[75] = '01234567890123456789012345678901234567';
        _defaultURI[76] = '01234567890123456789012345678901234567';
        _defaultURI[77] = '01234567890123456789012345678901234567';
        _defaultURI[78] = '01234567890123456789012345678901234567';
        _defaultURI[79] = '01234567890123456789012345678901234567';
        _defaultURI[80] = '01234567890123456789012345678901234567';
        _defaultURI[81] = '01234567890123456789012345678901234567';
        _defaultURI[82] = '01234567890123456789012345678901234567';
        _defaultURI[83] = '01234567890123456789012345678901234567';
        _defaultURI[84] = '01234567890123456789012345678901234567';
        _defaultURI[85] = '01234567890123456789012345678901234567';
        _defaultURI[86] = '01234567890123456789012345678901234567';
        _defaultURI[87] = '01234567890123456789012345678901234567';
        _defaultURI[88] = '01234567890123456789012345678901234567';
        _defaultURI[89] = '01234567890123456789012345678901234567';
        _defaultURI[90] = '01234567890123456789012345678901234567';
        _defaultURI[91] = '01234567890123456789012345678901234567';
        _defaultURI[92] = '01234567890123456789012345678901234567';
        _defaultURI[93] = '01234567890123456789012345678901234567';
        _defaultURI[94] = '01234567890123456789012345678901234567';
        _defaultURI[95] = '01234567890123456789012345678901234567';
        _defaultURI[96] = '01234567890123456789012345678901234567';
        _defaultURI[97] = '01234567890123456789012345678901234567';
        _defaultURI[98] = '01234567890123456789012345678901234567';
        _defaultURI[99] = '01234567890123456789012345678901234567';
        _defaultURI[100] = '01234567890123456789012345678901234567';
        _defaultURI[101] = '01234567890123456789012345678901234567';
        _defaultURI[102] = '01234567890123456789012345678901234567';
        _defaultURI[103] = '01234567890123456789012345678901234567';
        _defaultURI[104] = '01234567890123456789012345678901234567';
        _defaultURI[105] = '01234567890123456789012345678901234567';
        _defaultURI[106] = '01234567890123456789012345678901234567';
        _defaultURI[107] = '01234567890123456789012345678901234567';
        _defaultURI[108] = '01234567890123456789012345678901234567';
        _defaultURI[109] = '01234567890123456789012345678901234567';
        _defaultURI[110] = '01234567890123456789012345678901234567';
        _defaultURI[111] = '01234567890123456789012345678901234567';
        _defaultURI[112] = '01234567890123456789012345678901234567';
        _defaultURI[113] = '01234567890123456789012345678901234567';
        _defaultURI[114] = '01234567890123456789012345678901234567';
        _defaultURI[115] = '01234567890123456789012345678901234567';
        _defaultURI[116] = '01234567890123456789012345678901234567';
        _defaultURI[117] = '01234567890123456789012345678901234567';
        _defaultURI[118] = '01234567890123456789012345678901234567';
        _defaultURI[119] = '01234567890123456789012345678901234567';
        _defaultURI[120] = '01234567890123456789012345678901234567';
        _defaultURI[121] = '01234567890123456789012345678901234567';
        _defaultURI[122] = '01234567890123456789012345678901234567';
        _defaultURI[123] = '01234567890123456789012345678901234567';
        _defaultURI[124] = '01234567890123456789012345678901234567';
        _defaultURI[125] = '01234567890123456789012345678901234567';
        _defaultURI[126] = '01234567890123456789012345678901234567';
        _defaultURI[127] = '01234567890123456789012345678901234567';
        _defaultURI[128] = '01234567890123456789012345678901234567';
        _defaultURI[129] = '01234567890123456789012345678901234567';
        _defaultURI[130] = '01234567890123456789012345678901234567';
        _defaultURI[131] = '01234567890123456789012345678901234567';
        _defaultURI[132] = '01234567890123456789012345678901234567';
        _defaultURI[133] = '01234567890123456789012345678901234567';
        _defaultURI[134] = '01234567890123456789012345678901234567';
        _defaultURI[135] = '01234567890123456789012345678901234567';
        _defaultURI[136] = '01234567890123456789012345678901234567';
        _defaultURI[137] = '01234567890123456789012345678901234567';
        _defaultURI[138] = '01234567890123456789012345678901234567';
        _defaultURI[139] = '01234567890123456789012345678901234567';
        _defaultURI[140] = '01234567890123456789012345678901234567';
        _defaultURI[141] = '01234567890123456789012345678901234567';
        _defaultURI[142] = '01234567890123456789012345678901234567';
        _defaultURI[143] = '01234567890123456789012345678901234567';
        _defaultURI[144] = '01234567890123456789012345678901234567';
        _defaultURI[145] = '01234567890123456789012345678901234567';
        _defaultURI[146] = '01234567890123456789012345678901234567';
        _defaultURI[147] = '01234567890123456789012345678901234567';
        _defaultURI[148] = '01234567890123456789012345678901234567';
        _defaultURI[149] = '01234567890123456789012345678901234567';
        _defaultURI[150] = '01234567890123456789012345678901234567';
        _defaultURI[151] = '01234567890123456789012345678901234567';
        _defaultURI[152] = '01234567890123456789012345678901234567';
        _defaultURI[153] = '01234567890123456789012345678901234567';
        _defaultURI[154] = '01234567890123456789012345678901234567';
        _defaultURI[155] = '01234567890123456789012345678901234567';
        _defaultURI[156] = '01234567890123456789012345678901234567';
        _defaultURI[157] = '01234567890123456789012345678901234567';
        _defaultURI[158] = '01234567890123456789012345678901234567';
        _defaultURI[159] = '01234567890123456789012345678901234567';
        _defaultURI[160] = '01234567890123456789012345678901234567';
        _defaultURI[161] = '01234567890123456789012345678901234567';
        _defaultURI[162] = '01234567890123456789012345678901234567';
        _defaultURI[163] = '01234567890123456789012345678901234567';
        _defaultURI[164] = '01234567890123456789012345678901234567';
        _defaultURI[165] = '01234567890123456789012345678901234567';
        _defaultURI[166] = '01234567890123456789012345678901234567';
        _defaultURI[167] = '01234567890123456789012345678901234567';
        _defaultURI[168] = '01234567890123456789012345678901234567';
        _defaultURI[169] = '01234567890123456789012345678901234567';
        _defaultURI[170] = '01234567890123456789012345678901234567';
        _defaultURI[171] = '01234567890123456789012345678901234567';
        _defaultURI[172] = '01234567890123456789012345678901234567';
        _defaultURI[173] = '01234567890123456789012345678901234567';
        _defaultURI[174] = '01234567890123456789012345678901234567';
        _defaultURI[175] = '01234567890123456789012345678901234567';
        _defaultURI[176] = '01234567890123456789012345678901234567';
        _defaultURI[177] = '01234567890123456789012345678901234567';
        _defaultURI[178] = '01234567890123456789012345678901234567';
        _defaultURI[179] = '01234567890123456789012345678901234567';
        _defaultURI[180] = '01234567890123456789012345678901234567';
        _defaultURI[181] = '01234567890123456789012345678901234567';
        _defaultURI[182] = '01234567890123456789012345678901234567';
        _defaultURI[183] = '01234567890123456789012345678901234567';
        _defaultURI[184] = '01234567890123456789012345678901234567';
        _defaultURI[185] = '01234567890123456789012345678901234567';
        _defaultURI[186] = '01234567890123456789012345678901234567';
        _defaultURI[187] = '01234567890123456789012345678901234567';
        _defaultURI[188] = '01234567890123456789012345678901234567';
        _defaultURI[189] = '01234567890123456789012345678901234567';
        _defaultURI[190] = '01234567890123456789012345678901234567';
        _defaultURI[191] = '01234567890123456789012345678901234567';
        _defaultURI[192] = '01234567890123456789012345678901234567';
        _defaultURI[193] = '01234567890123456789012345678901234567';
        _defaultURI[194] = '01234567890123456789012345678901234567';
        _defaultURI[195] = '01234567890123456789012345678901234567';
        _defaultURI[196] = '01234567890123456789012345678901234567';
        _defaultURI[197] = '01234567890123456789012345678901234567';
        _defaultURI[198] = '01234567890123456789012345678901234567';
        _defaultURI[199] = '01234567890123456789012345678901234567';
        _defaultURI[200] = '01234567890123456789012345678901234567';
        _defaultURI[201] = '01234567890123456789012345678901234567';
        _defaultURI[202] = '01234567890123456789012345678901234567';
        _defaultURI[203] = '01234567890123456789012345678901234567';
        _defaultURI[204] = '01234567890123456789012345678901234567';
        _defaultURI[205] = '01234567890123456789012345678901234567';
        _defaultURI[206] = '01234567890123456789012345678901234567';
        _defaultURI[207] = '01234567890123456789012345678901234567';
        _defaultURI[208] = '01234567890123456789012345678901234567';
        _defaultURI[209] = '01234567890123456789012345678901234567';
        _defaultURI[210] = '01234567890123456789012345678901234567';
        _defaultURI[211] = '01234567890123456789012345678901234567';
        _defaultURI[212] = '01234567890123456789012345678901234567';
        _defaultURI[213] = '01234567890123456789012345678901234567';
        _defaultURI[214] = '01234567890123456789012345678901234567';
        _defaultURI[215] = '01234567890123456789012345678901234567';
        _defaultURI[216] = '01234567890123456789012345678901234567';
        _defaultURI[217] = '01234567890123456789012345678901234567';
        _defaultURI[218] = '01234567890123456789012345678901234567';
        _defaultURI[219] = '01234567890123456789012345678901234567';
        _defaultURI[220] = '01234567890123456789012345678901234567';
        _defaultURI[221] = '01234567890123456789012345678901234567';
        _defaultURI[222] = '01234567890123456789012345678901234567';
        _defaultURI[223] = '01234567890123456789012345678901234567';
        _defaultURI[224] = '01234567890123456789012345678901234567';
        _defaultURI[225] = '01234567890123456789012345678901234567';
        _defaultURI[226] = '01234567890123456789012345678901234567';
        _defaultURI[227] = '01234567890123456789012345678901234567';
        _defaultURI[228] = '01234567890123456789012345678901234567';
        _defaultURI[229] = '01234567890123456789012345678901234567';
        _defaultURI[230] = '01234567890123456789012345678901234567';
        _defaultURI[231] = '01234567890123456789012345678901234567';
        _defaultURI[232] = '01234567890123456789012345678901234567';
        _defaultURI[233] = '01234567890123456789012345678901234567';
        _defaultURI[234] = '01234567890123456789012345678901234567';
        _defaultURI[235] = '01234567890123456789012345678901234567';
        _defaultURI[236] = '01234567890123456789012345678901234567';
        _defaultURI[237] = '01234567890123456789012345678901234567';
        _defaultURI[238] = '01234567890123456789012345678901234567';
        _defaultURI[239] = '01234567890123456789012345678901234567';
        _defaultURI[240] = '01234567890123456789012345678901234567';
        _defaultURI[241] = '01234567890123456789012345678901234567';
        _defaultURI[242] = '01234567890123456789012345678901234567';
        _defaultURI[243] = '01234567890123456789012345678901234567';
        _defaultURI[244] = '01234567890123456789012345678901234567';
        _defaultURI[245] = '01234567890123456789012345678901234567';
        _defaultURI[246] = '01234567890123456789012345678901234567';
        _defaultURI[247] = '01234567890123456789012345678901234567';
        _defaultURI[248] = '01234567890123456789012345678901234567';
        _defaultURI[249] = '01234567890123456789012345678901234567';
        _defaultURI[250] = '01234567890123456789012345678901234567';
        _defaultURI[251] = '01234567890123456789012345678901234567';
        _defaultURI[252] = '01234567890123456789012345678901234567';
        _defaultURI[253] = '01234567890123456789012345678901234567';
        _defaultURI[254] = '01234567890123456789012345678901234567';
        _defaultURI[255] = '01234567890123456789012345678901234567';
        _defaultURI[256] = '01234567890123456789012345678901234567';
        _defaultURI[257] = '01234567890123456789012345678901234567';
        _defaultURI[258] = '01234567890123456789012345678901234567';
        _defaultURI[259] = '01234567890123456789012345678901234567';
        _defaultURI[260] = '01234567890123456789012345678901234567';
        _defaultURI[261] = '01234567890123456789012345678901234567';
        _defaultURI[262] = '01234567890123456789012345678901234567';
        _defaultURI[263] = '01234567890123456789012345678901234567';
        _defaultURI[264] = '01234567890123456789012345678901234567';
        _defaultURI[265] = '01234567890123456789012345678901234567';
        _defaultURI[266] = '01234567890123456789012345678901234567';
        _defaultURI[267] = '01234567890123456789012345678901234567';
        _defaultURI[268] = '01234567890123456789012345678901234567';
        _defaultURI[269] = '01234567890123456789012345678901234567';
        _defaultURI[270] = '01234567890123456789012345678901234567';
        _defaultURI[271] = '01234567890123456789012345678901234567';
        _defaultURI[272] = '01234567890123456789012345678901234567';
        _defaultURI[273] = '01234567890123456789012345678901234567';
        _defaultURI[274] = '01234567890123456789012345678901234567';
        _defaultURI[275] = '01234567890123456789012345678901234567';
        _defaultURI[276] = '01234567890123456789012345678901234567';
        _defaultURI[277] = '01234567890123456789012345678901234567';
        _defaultURI[278] = '01234567890123456789012345678901234567';
        _defaultURI[279] = '01234567890123456789012345678901234567';
        _defaultURI[280] = '01234567890123456789012345678901234567';
        _defaultURI[281] = '01234567890123456789012345678901234567';
        _defaultURI[282] = '01234567890123456789012345678901234567';
        _defaultURI[283] = '01234567890123456789012345678901234567';
        _defaultURI[284] = '01234567890123456789012345678901234567';
        _defaultURI[285] = '01234567890123456789012345678901234567';
        _defaultURI[286] = '01234567890123456789012345678901234567';
        _defaultURI[287] = '01234567890123456789012345678901234567';
        _defaultURI[288] = '01234567890123456789012345678901234567';
        _defaultURI[289] = '01234567890123456789012345678901234567';
        _defaultURI[290] = '01234567890123456789012345678901234567';
        _defaultURI[291] = '01234567890123456789012345678901234567';
        _defaultURI[292] = '01234567890123456789012345678901234567';
        _defaultURI[293] = '01234567890123456789012345678901234567';
        _defaultURI[294] = '01234567890123456789012345678901234567';
        _defaultURI[295] = '01234567890123456789012345678901234567';
    }

    // ...
}
