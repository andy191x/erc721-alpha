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
        _setBaseURI('ipfs://');
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
        _defaultURI[1] = 'QmdieSnhHvc1YA74keEzZ1jSo49ZjEVCyQehe2PDDfEtTv';
        _defaultURI[2] = 'QmXyVxrHAsjyp4ttx548Ut5MWZhwkRKHcU68eN5g4q2wBL';
        _defaultURI[3] = 'QmbHWBAsc2HjiCr5a53kzEr2FcJ4NpsVYcQsggVhxbuZwr';
        _defaultURI[4] = 'QmUv7HYBaExkoMAUkvViWsnFboU6nSfvoNuC6bPzMHto3J';
        _defaultURI[5] = 'QmWWeruQhU8pSBsjFfiBGLrDbGk1oHjhatnMHyL1zenuxn';
        _defaultURI[6] = 'QmdNZjAZ7jo2GP5iRrtSDijW9DTSyuErmod3CRjEKrFDEM';
        _defaultURI[7] = 'QmXEsk4jBATcUuEjyFuGPGzoG9DcvCVBFVJewymbNR7fLg';
        _defaultURI[8] = 'QmNpqUZ9g1177nf7urTh8U3gGjhVsQpqqdQXtyXrR38QQG';
        _defaultURI[9] = 'QmT5YBmMqQxtaH5HstnhXP44GK4yropV3uiFuC3BCnjVXU';
        _defaultURI[10] = 'QmVQmLqEjeH6oqiE1PV6dDrSkwfx4AX9EJpN9pMHCti79X';
        _defaultURI[11] = 'QmUvwmYgjZQLFvKKkS9ukgm8CVusrJ7z9ksBtkPF8bKgfC';
        _defaultURI[12] = 'QmQvvJCcDi5yAhpK3nGpqL85FdKETc3zqpEoVkDxzYHZfH';
        _defaultURI[13] = 'Qmd1GyuhzBCciQ3JqxhAvHRh2znQ7g9FnqNpznHqpVCAy4';
        _defaultURI[14] = 'QmWnH7MqKkUmUhxskuNwErZ6DEjyTvMED74hZrNLYfTjmA';
        _defaultURI[15] = 'QmP7BEJTQz7dDNzF5rdt8NJa5sRmLG5ypT4Arc6cN63T68';
        _defaultURI[16] = 'Qme5yPUPRmUn7NLZzA7za1xDHYQhyGxTN7E8bZjjqsAEvX';
        _defaultURI[17] = 'QmRxT9yPHPFFWomM4eVPbqv5E5kSaZhCrQmSbEDCF8jzM6';
        _defaultURI[18] = 'Qmc4WCNGnT4sxu4mGvNnkzQZysxcWNLHNdPQdNF69wVGsG';
        _defaultURI[19] = 'QmQA9vxMUZr2w2kKGr4h2aUphJzkUNoN7ngKTe27UeQV3F';
        _defaultURI[20] = 'Qmca9BiwCX8qv5RsUsiYdK5U8RhLU6vwAmjd8a5rmdQ8UE';
        _defaultURI[21] = 'QmTKoRWZAmkdrJ6mkWVtzt5NR2Lt3DUQ22omocjJ8zCiA5';
        _defaultURI[22] = 'QmekxeZHcRwKfAZhVd7z4YAQkjAfL86m44EjdyydjgrhkZ';
        _defaultURI[23] = 'QmbNAkUBVm5EEuSAYcFzk6prR2WQ98cU5jyvSUqmVZZ6j9';
        _defaultURI[24] = 'QmatEMJzXsosDgtsYmvXpsYrhvV43oAEPUuvzcr1gKArp9';
        _defaultURI[25] = 'QmTtFpusqAyXfGq4dZx8PJoVBJtnWrXFGAZUD8qsqAfkSY';
        _defaultURI[26] = 'QmafCqkVyRp9y4Yhz564A6FhKAi9GppM7TzVH7Rd647Ukt';
        _defaultURI[27] = 'Qma2aTDzFSzuATrNuvuvdQyLSuy3W97gnq62jDSwTVGRC7';
        _defaultURI[28] = 'QmZvnoHG6n9ABv3GwS47ay4o9sjVX5NfyqvRcugKkCsXGs';
        _defaultURI[29] = 'QmeAvZv1YpGj8yy23RALsNbY9RtRbvQRPe7vLRTmEa8nZF';
        _defaultURI[30] = 'QmNd8jqSStGQHsbTDvSXEXhUtGG6tSrhuq6mxSsnfNLgm1';
        _defaultURI[31] = 'QmY1WcFziiJKVpD2EWEnZCrdxh3rNcZKDk8yodqxNFsq2d';
        _defaultURI[32] = 'Qmew4qHxD5ht9HzytHAFnx2vEWBM2kMsCTghh3t1SPPdvj';
        _defaultURI[33] = 'QmU5HnwfXkcQGiRkREww4btf1rUhf1QDMwLmbixbJoKrGJ';
        _defaultURI[34] = 'QmQ9UQ2SS4MwZawAZ3hHMxXTfiDFYQXVDvZpB9dN1CGqGn';
        _defaultURI[35] = 'QmWuBSMrFLHaoQzbx8zMUAeoqhvo9PEsvnK9dkbNJ74QZd';
        _defaultURI[36] = 'QmZa8FWLAWpemYu1nBV5PJWJRxV4GAw3WygWVxA5AFmJkr';
        _defaultURI[37] = 'QmYVDE8hL4wrkXbFCmYBU5qRi3wgANLSPWqgEPxux8892Q';
        _defaultURI[38] = 'QmcJd81r7EyvNvBZe9CnZb5AKYD9ZDMttQBBAqfkYnXDfh';
        _defaultURI[39] = 'QmUMoBfUHcEFusa24awGvQRk8D3T3akYQDz5LBWkgG5L6h';
        _defaultURI[40] = 'QmcAvwrU82K2yN3vtJcNzdpB6NcDShkrQA35vmVzsunbof';
        _defaultURI[41] = 'QmQa11ii59M7AbWs5R78uHpp1t9imJVcXyFWSBmLSqZsgU';
        _defaultURI[42] = 'QmbJ7qABzMbbDXGj9GsFY1uu7nUddzkULXDiM1UK7tSfVV';
        _defaultURI[43] = 'QmNegpv8iaUgCVanvcURq3x1NGW1D76ed62GhJ3XguNYHZ';
        _defaultURI[44] = 'QmW3osRtfBk1tKs56tZCgXLAu59TpE6nsA34a7FRzouN8r';
        _defaultURI[45] = 'QmPDGczV4GLXWZacZq9zM1ft76F64meghUW9iGJKs23Yo3';
        _defaultURI[46] = 'QmRnJttRiwanqKw3abUdhY5Jg8eyz5a3VCL2nDQErwPWJA';
        _defaultURI[47] = 'QmcFAvMoCE4ifsXmzmDheog9z2jAy3hwrqnzBwk8UQw6Yv';
        _defaultURI[48] = 'QmVDRtz7GnwPCsRye5W9c4Trq8hJpMe4HQm9EXAE3Q62Co';
        _defaultURI[49] = 'QmRiet1iDnGg3Ljcn1FY4YFy2ZqxkxSrgiRKfPw5p3NY8H';
        _defaultURI[50] = 'QmPHUUnxsqgbHWFByrBQtTBpiLM2VwtxYUNg994UAu7sDh';
        _defaultURI[51] = 'QmYfx64z5u91SDdqcY9gFnadfa9AAbwR5M6NbAe2219EHK';
        _defaultURI[52] = 'QmXwMD2SAbZRuQbKet8E4m9GU8TBxsAkKLJBDtHQPKGnDs';
        _defaultURI[53] = 'QmRAXqRAG4UkBiX8VxXBuyuKHguDkWzGTtP5tMLjLxt73i';
        _defaultURI[54] = 'QmQ4oJA2ryQURivVvC9tXsJ1z6vVcBsrwS5GrD153fwh2K';
        _defaultURI[55] = 'QmduTLexoZNNAQ2DbY17adJRa52xCGVeLxrZZaeTtzQiTh';
        _defaultURI[56] = 'QmZ6rehq4mj9ossyecSxF7dsvsQUyB1t19m1EugR1hyedA';
        _defaultURI[57] = 'QmPRtSSnAArMagwd24ZsEmV39SaEdobKxT9iSxJePtQHkp';
        _defaultURI[58] = 'QmeyuMo9171HkC6bjKJhHsm48nqmzbUQc6xNuULup2xnEc';
        _defaultURI[59] = 'QmNwLUbAHtmaVGgUCPLEd6PJTmtUSis8tqogdkkngH17cz';
        _defaultURI[60] = 'QmVxeCHSw2BbCPF74fUzKFRpeTmAjeBz8oz6TMLb7m27sA';
        _defaultURI[61] = 'QmZxPxs29Th1mMbKKmT4BcF8wQ8MkvxCzoz8G2xZo54mG4';
        _defaultURI[62] = 'QmSLekbrwjtLxqwG7YMM6bhLaeK99Axxp7eoNyLDT8B8Si';
        _defaultURI[63] = 'QmZsqJiBcSrY13JpcZsfB2gCx1gRx2W1tS5B12u9LZqD8e';
        _defaultURI[64] = 'QmcBh86RHjACypMPnJuZh9bkJ8ht4T4aDVyyKhZv9W9tch';
        _defaultURI[65] = 'QmYEV1KLeYQ8ASvxW6gvBFsfqHhxAZvHb3CohQUWJ4exYA';
        _defaultURI[66] = 'QmeL6JM4RMDSvkYswFgPpUiiCmJ75mFLgnCz4VM4udBqJ3';
        _defaultURI[67] = 'QmREmjMrQizb73ULnT5UXMYkRATcthKsQy4pEsx6bn2HXH';
        _defaultURI[68] = 'QmdmbpN6s3hocX19nFxzSCCEP3Lf4gqUbodDvSwNidTgXK';
        _defaultURI[69] = 'Qmc5Cygbn3nuQokNP7GYD2R1Z2Qh5DosEDSP3m5cXrgzCH';
        _defaultURI[70] = 'QmbY1ErpiJDkZoSK7UcDtVG3JfQbRycom6kXgDj3b9qZ7b';
        _defaultURI[71] = 'QmZtpybxvBdSFqtbxXwzHFWeAgvApkc7rcEcEaLdbaDELu';
        _defaultURI[72] = 'QmUvvngwX3zSQCXxyn32gLXDhxpvTi3caVV5nuAmKsQKLK';
        _defaultURI[73] = 'QmdMr3PAwqQaAhHSPTCEE3mJobcAsESa5Tvm1M7AzYohjg';
        _defaultURI[74] = 'QmVDTV6JEFZE6A3QYxtbhH4vaiGDsBaTwhoo8QphUQBNuf';
        _defaultURI[75] = 'QmQgHGyMRxeqY1z7KXob5nyGrppMHaUoeqJefgBYEN5Feb';
        _defaultURI[76] = 'QmVk4RcGmrfnZk2YUQK2RgGqMcUPQmdgqCenTWrkAhUhm3';
        _defaultURI[77] = 'QmaACsWXNban9UQWHNz7XG5EFipGugiUj2DFm5QrVb1dqm';
        _defaultURI[78] = 'QmeamQDsSPqqGmreT7mZjFAG9DipEpkSQK3ogMmPpzRcF9';
        _defaultURI[79] = 'QmUpVkxg5oDuCMCMXmtxrYRaGieWsQxC9p8dgmDQrNviZ7';
        _defaultURI[80] = 'QmWk3EcMSpskkQAYM5TdWPzAM1wmLi2KpajnsSS6CnStN5';
        _defaultURI[81] = 'QmT6KSjxxJYFA1bf4bqxhxqsYCTzgHgDDdmQtKQLXu9YNT';
        _defaultURI[82] = 'QmQgQbtYgXbGfMDqqcw9sFT1UFZoaccxYNY36iUFrQqJU5';
        _defaultURI[83] = 'QmSEh2jdAyNjgNsCrdhBBERQK7rDjucaL7LSMJWgCZfGLb';
        _defaultURI[84] = 'Qmcg5zoThRrNN9b4vY7sJ8nTpzeJ7NSyfRV65YMvkTZRNF';
        _defaultURI[85] = 'QmbaiGu9Epu4dM2QXr41Sqvyfv7NB9ck7LVn4fdjZX49wT';
        _defaultURI[86] = 'Qmc8nZG5z9jSpvaxuvosczj97sxkpJ4mMLcSk826PNJMho';
        _defaultURI[87] = 'QmTJ2B5AKtKpfFqA9HMewpLnzZdxPvmEAFQBq88wEchPP7';
        _defaultURI[88] = 'QmS3kdKnxWYQxnDzjSuH53dWUKGskDzepTKstN7KJXZxjp';
        _defaultURI[89] = 'QmZUR6LNVycwcgaU9ERNxVGAf6XqWYUJH7Y5uDS6cJJ1CR';
        _defaultURI[90] = 'QmYa3vp944Ru1KH9xuGa6ZGdvbfwNEnodhCyKkCg1tjKJy';
        _defaultURI[91] = 'QmfLefjbhC6wtV8zHiUo32EoDyDHsvNyBkkzVkNYPDKRqe';
        _defaultURI[92] = 'QmZh2mWKFT5riLmaQEuHKNvX4BvAKUWgy6Sts9beRWnsRV';
        _defaultURI[93] = 'QmXLPvCmuG6Ff7iznc3ymctiH6dbBHYzgX423vRFxmcCG1';
        _defaultURI[94] = 'QmToxDigLEGEMrPBNwsEmwwwN4e24BbpsgHbuSAurgNDdW';
        _defaultURI[95] = 'QmaX4cKnhHAYoFJ2sKbkvWxq58Rns2K2BLka386kixKBHP';
        _defaultURI[96] = 'Qmd3wrC2yyRpufhgAWwS35QT7Mw9MWMYrEMXYDG3ejLCFP';
        _defaultURI[97] = 'QmQas37GSfohS1QNVULDuj4GzNCQGU1mQqcnotbZLx4915';
        _defaultURI[98] = 'QmYusxozm3AzXCKLAPF1vQSwCGdJcChueC1E6twi57MVJ4';
        _defaultURI[99] = 'QmTb3gWxiyUQgUs4DJBX1otFggjt3RAXADUWhBbwLaRLn5';
        _defaultURI[100] = 'Qmdq9wJE9mFSXC7xU3UXru8GRBg5cWkb8RcxdPAK8XW2Bj';
        _defaultURI[101] = 'QmNThEhZ1dYLfBX68vVFdx9jbRnoTMhNqX8ctGBAX7oWQq';
        _defaultURI[102] = 'QmUM7Jj37CHZmeozdetmXTrsPPFZMVocPwQLEhXYGqqwii';
        _defaultURI[103] = 'QmR9qFMAyWdfpCf8VVX2GHZpzn4c6G1sV5mwfVbHzKjfj4';
        _defaultURI[104] = 'QmWadCKAZhnwy7Hj8yxU6uH7hMDxbPsgeZio6b23mVXYXF';
        _defaultURI[105] = 'QmXWSpAE4SfEF2KXDo67icDxZ2nCoVW1xnuABRPsBqdckS';
        _defaultURI[106] = 'QmccTPuYUJRwsV6C41zvGoAhfGdwSGmsUqyiRsJuSc6YUk';
        _defaultURI[107] = 'QmdALK2EMZZ44ESha81eEkyAzt2BY3NjtWK1TbY7fJ7KdD';
        _defaultURI[108] = 'QmbLpQ5iiVZ4GBdTww9fH3yknVtbmXEAUg7LFfC1v64zei';
        _defaultURI[109] = 'QmSw5m1SSRBMRan3vFcuV4LbZFPiUtARn3cLtaLStWPkYq';
        _defaultURI[110] = 'QmUzWxE2iq8UL36rnHSVWdbG1pppzCtHs8w7ATBYb33gCf';
        _defaultURI[111] = 'QmZc1oReM7tNmujhVHSes69sN2cXysbYp3f5CgBCphLbi8';
        _defaultURI[112] = 'QmUy1Yf2vbGkRy8qq9roqeYYja5zrgoXYV5kyJgcx7bY1N';
        _defaultURI[113] = 'QmavvyPcNxDAVRfg7bunbKAqdHAWB3RHUXTnRcib7ktRhp';
        _defaultURI[114] = 'QmVdvatws9p7DPQw47NH15K5p3ZgLc2b9PWcaRmbpTCqKw';
        _defaultURI[115] = 'QmTYiyzKVQ4se21AwxzpCeM64x4GYx5E2TRU4bvNdq5X8L';
        _defaultURI[116] = 'QmcLdaVfY1DQDxoQ7rePjde3rde3as5nrtigaQ9eiqyNqb';
        _defaultURI[117] = 'QmagKimXEAjmzehA9ksKJA4VyqCF2kCDt6hVW3hAUhY3yW';
        _defaultURI[118] = 'QmS4LrUNFymhkzLuDNn8fk1MH9fQA92Kq4JqvFixSSSn1Q';
        _defaultURI[119] = 'Qmae4uKHHUy4Gr2fjPwBpWz79d3ZgPrpDFRvAUsRi9fmDz';
        _defaultURI[120] = 'QmX6tdKLEZ28iqjBqu3rcG5GfptrBxypNXnYgYkCbdRJRT';
        _defaultURI[121] = 'QmcVDiEHcnzUYN79WGrVaJD2DjMS8J2nqhQsSXEkX2ZeAm';
        _defaultURI[122] = 'QmQYNd1Dqsxggp3HfWreMRRgDJUtmzi9LBKZbvL8gjYiZt';
        _defaultURI[123] = 'QmRjMN72bQ7TH1toszCZV9LbZAsDXnyArnVoLx5b7t47Uw';
        _defaultURI[124] = 'Qmeg7j8SGTZNVZpwXzjXV9FUGTVDjSeu2FMa5n98WZWJRS';
        _defaultURI[125] = 'QmccWVQemSaWmRLu2U2XLQDTjUpw6V93YK5nTAfiksSjqz';
        _defaultURI[126] = 'QmRKhHmWFzExnyWLNSYCkuAgHyu31q6XiPBmwKjy8kACxp';
        _defaultURI[127] = 'QmVaYyzq8jrNuLnrDuHNJRwq3w9dPSy796jeXbwMAr4mWX';
        _defaultURI[128] = 'QmQ5RFX8Ei6TABoNRAZZwX7xQZFwabPo6sgAMqpnzgLAZy';
        _defaultURI[129] = 'Qmepqf7BF3pdBUioQm5i9WnqskCG5oDADqQvhAN9z5dyaQ';
        _defaultURI[130] = 'QmXM4P13cfVFquM3ctpHHDDiW5ViWcPdYsyFa1dD4VPpYd';
        _defaultURI[131] = 'QmUwt9Ubvs3B9VYjk4UTN1L8YXZHUHZDmneHkHJpJovQHc';
        _defaultURI[132] = 'QmTF75LXeCmkc8jjqZTpJpxo4efKGCVckxehGDzZ6tymgT';
        _defaultURI[133] = 'QmNoSzVMj5EN6VaokUkT1duyxJ5Acr9cvh4f5nEsCZuJWv';
        _defaultURI[134] = 'QmW3u6zxgm5XQAM6kA3Wbho81V8h2bJ3ox1EfjGC6rtU9R';
        _defaultURI[135] = 'QmQ4jfvG61iZdp7qfvWGRLkRoq3iGAJLHQjftQYkdurMRJ';
        _defaultURI[136] = 'QmQyXNA4HA383yULkMQxtydswEkLB1cEcbvuXdPtLJVSfF';
        _defaultURI[137] = 'QmRgGeRaZkGvShDbqoQukCoh39TV6jQ3gXcAFfL5YeyUut';
        _defaultURI[138] = 'QmUgWQw57UVVabSDxps68aUT4MgMvw7c9zckBdi6mbit3J';
        _defaultURI[139] = 'QmQL7gm5vTJzBsBLLgmYrY38S8WmKREDZn6tHNLuMG7sEE';
        _defaultURI[140] = 'QmXc1zBipQmsDvzX7pSsLJzcmWiDh5nC69tqqkwuY4DrM1';
        _defaultURI[141] = 'QmacsemnbDv6jhWgg7yofqK5oCpvCeTFWwbH5Uz5hdHCg2';
        _defaultURI[142] = 'QmcANCeXJQXcZeXSqESgiQ1u7SwQFpit1XgmrgA1UzrhjF';
        _defaultURI[143] = 'QmRMf7GxjCF23ijprLSW25Z3f6vZAgmyKzBiUPAkmowQF7';
        _defaultURI[144] = 'Qmcsd2H7XBx4sAqNN6TafSWkGnYkdieqMtFhVkPxP4oWqW';
        _defaultURI[145] = 'QmdNEHPeVpwd2kKzT9FCsUJhBQ2FXV3U3mfEVkSBrR9a1u';
        _defaultURI[146] = 'QmRDAf1AMkpjHwpeM9pNk49hYyj5akaEjAVsaFf2d5ekyZ';
        _defaultURI[147] = 'QmSxAhzbB8dDr5CxVJUchmaJzprkw3teTyjGWnSG9m5fV1';
        _defaultURI[148] = 'QmTH6vJygxLq2oMd38hysVQUDAu68XKsCYUWygVGHMkS8u';
        _defaultURI[149] = 'QmXSGLGrjr7pvS7TXmf2yJce9UQttHxJivdrucut6sULBS';
        _defaultURI[150] = 'Qmd5G8PAjuYhF7EDWsCiT1LEuWHZxxBGsCRpLRpAY6HQSv';
        _defaultURI[151] = 'QmVWiVux2y1CBC3NmbVgPXrHWHoj34KMdJzg41JLjQGzxm';
        _defaultURI[152] = 'QmURMoSGDEsHAHAtMAi5bBeKqTRFuDRqMMxHmddQFZRrgq';
        _defaultURI[153] = 'QmQSL1WghYsJk9ENf8RuQ1Zzng8mC68yKwLb8bDVigjkvL';
        _defaultURI[154] = 'QmYUyZ4tQHqxqtxW5KS3eLCkcxs6pDi5hvnevuem4guWNy';
        _defaultURI[155] = 'QmTfTTDXr9Fv9Sb86QZ6B2mK4jJRM3sVqBzuPwdnSFUcXp';
        _defaultURI[156] = 'QmRFJ7yo6dXbL7Bn8e7KEmvHzaToYNksNjwitPtR3fj6tz';
        _defaultURI[157] = 'QmZCHYUNBnMbRtARiJxBjBRPQCqoUYV8jR9KgAK6AfLiPb';
        _defaultURI[158] = 'Qmcf9G8KecbpYVYsBQ7ih64x9mEXxY3XFjDhNeDYFCkckV';
        _defaultURI[159] = 'QmQvu3yVh3cBKoZyXdd2QYE1XDmN6Y4n9ny1AgxPJf19zU';
        _defaultURI[160] = 'QmV7pfnT6hEYxVUNcDPUGuJzpgCQaR5eReSKVaNSvmZT4Y';
        _defaultURI[161] = 'QmbiA7VpApoyRdFqUfVTNZMXMNrVQEQmMhZpmcwvhSbxrm';
        _defaultURI[162] = 'QmRyowgwZv7ADRtoGUp7V46XYB14uPWQgVJ7oN9SWnzMT5';
        _defaultURI[163] = 'QmTxRnUBTjH3Cj1y1RLBFZrJmM264vZz9wrPBTUA5PTWQ3';
        _defaultURI[164] = 'QmQ6RnDm7W51sCJuqqFdV1GnDZEypQ7VQokF2xrs1geGeu';
        _defaultURI[165] = 'QmekeQc25pjStXoaYU28TniCTmzg6yYCXGdNwykPmpbHi1';
        _defaultURI[166] = 'QmSCu3qGZbSBLF5e2xWiuNheptU3TTS9N3wvDghNppD436';
        _defaultURI[167] = 'Qma5qvWN4AMp2eWQcyxEDtKoRjjnuCmwsJbSZcjEzRcG2k';
        _defaultURI[168] = 'QmezRFenaFamu56nRYCGjteU5CTLF6Pxu8rzShddDQ6f2x';
        _defaultURI[169] = 'QmZA7gx9xDoUA8muBRPrDvvQKRGKcoQKRj5swegahTqxyp';
        _defaultURI[170] = 'QmQ2Fht2omHKsaGr6xhDwuo44ppb9qwQTUQ8VG8UhVFU8o';
        _defaultURI[171] = 'QmXeQBGhFCLpx7tQdw4sVPhJKu3VHXKXWkKoGr4vBw85ye';
        _defaultURI[172] = 'QmYDEcjrGpmxLmKkjDVesNCDhjdCtXYJgTYtwT725tNq8s';
        _defaultURI[173] = 'QmcQ7mCzFkTFK6NSEUi96A6SiKo7Yo6mMVzXm5gJx77xf9';
        _defaultURI[174] = 'QmYb63Ld2JSsLdF1oyMA1hVxKztnDF9VUPBeSTtEML6N15';
        _defaultURI[175] = 'QmZDGtSMFhQomCUfMASWoTLMHDpv86ZU9GnFs4MK9czPEz';
        _defaultURI[176] = 'QmTfrsfZFwj2UKkqJ5eGhMkwRgZJbA2DqfB1Tm1kE7yB9b';
        _defaultURI[177] = 'Qmcqr3C5vcZDW92vaSmTJuZtnN5nffMugFczMxC4bAoFJf';
        _defaultURI[178] = 'QmXkgr6tJFYbtSiUkpaC8jwgFpMzLVaQnUrpsnhZeTDMLT';
        _defaultURI[179] = 'Qmc6GpkXXKXyE2FNRe8xwGgnR9Cm2z1WLMt6Va9ux1FTjv';
        _defaultURI[180] = 'QmV1qePU8fvnv1FFRR7Tv1Jq24LpqJ5hvpd3krVfDLSdfK';
        _defaultURI[181] = 'QmVNRJZJF4dMixEAQ4rVGcvHnLqj5Xxu8HH7PxRBYFNi2o';
        _defaultURI[182] = 'QmbGiWzZbiYg3xXEKp4aCaAHTzjCKvFF1Y7TGoEusn5V4z';
        _defaultURI[183] = 'QmS57S4MGk7FEvJrpv4n9rYwDPTsrisLEXagwFTMp5nk2S';
        _defaultURI[184] = 'QmYCarYCzq3mzVhr2iMfZw2jGBVgy5nPqidWnN6kP8rhiH';
        _defaultURI[185] = 'Qma9TyHV9mTCQH4g9idMmnnn8A2x4h7RFoQFjjQf8C84Vb';
        _defaultURI[186] = 'QmYdnUj7L85CsqctwUpu3KJQL1429efWJ6GHW6MDkisdh3';
        _defaultURI[187] = 'QmcaCrKnC756wbgZdCoutbzySpNRqqMUhYSMN4sf3QVWUJ';
        _defaultURI[188] = 'QmZ3yRidfejuhy9at317GYxJ1TAjSVX4i7Qv5Hmd6UngVR';
        _defaultURI[189] = 'QmeCVba9eVe2pS8m4zwVNSoM37FDTUC5KoJ65fAeCo5BDp';
        _defaultURI[190] = 'QmXAJtJQ58GRACfMXU7dPEYXzACKt7SAzzYimuZM4awsYd';
        _defaultURI[191] = 'QmRtxv3kgmH4GRUEjwGThyKLvtWRTmgzHxAJLWFNT7Jba1';
        _defaultURI[192] = 'QmYRJqx4R9QBrFe67DxLQRM8EJSBsbX48w1MoWSuR1CF1R';
        _defaultURI[193] = 'QmYYgATBA28Ve2q1ZarTu5mqczTNJzeXw9rVxWVLoqRcDF';
        _defaultURI[194] = 'QmRD7fStZnKPqQEeiwQvwZLpXTT3PHkoRATbsHf8M3GJy4';
        _defaultURI[195] = 'QmS8DogigTnLaxWAvcHwrcghxiUTsu4Tps6uwj4ejEkchP';
        _defaultURI[196] = 'QmdNrTzZ48vQbtCaahCKQTdUfpsfvJQS6r5UckgRRbUpwt';
        _defaultURI[197] = 'QmYUPRW2fjww8nBBgBM7g9pVxk4NiWRczVYiVU99gKjEQj';
        _defaultURI[198] = 'QmaryPZxxNzkMytgq1yWkyxtaJZqCCo4oCuDep4JA1x9HV';
        _defaultURI[199] = 'QmdqzHEGu3ADGioeywZ9xzxrhaz1s64zSAnhHVLzpVqk5N';
        _defaultURI[200] = 'QmeWcW32C88nMQkeFVVbRjjsRMauyhnkTtNRJy8M77H7WP';
        _defaultURI[201] = 'QmRRGifL7JXfmKGR1v3wbh1ceLjJ1p9DGDqtTfgGDFaw1U';
        _defaultURI[202] = 'QmRmWZQKvCsf4Kv1LNPzEKx6NPtsc92CN67micxsX6kNit';
        _defaultURI[203] = 'QmSAHcCwVFZwAwMHJok48uDMF2BLSYVuTvdhBMLjx11knh';
        _defaultURI[204] = 'QmaiztA1sM4uiFWRg56tHN6DqN67Cdd4mv3wXBLipAPEgx';
        _defaultURI[205] = 'QmdxeEa9JGtPL3aAMtfsJB1uFhCcciA6tM1YbrysNECTAx';
        _defaultURI[206] = 'QmNtCGo8t2e5VnmsMTHuBS6uMtUnNwBmSbFpxbhqy1QJ18';
        _defaultURI[207] = 'QmW6wnnMMApLTm9nbEqeQeT7ruJmMeAhoHU7GUEjDzs7dG';
        _defaultURI[208] = 'QmNLj85ZFhfMW5HwQbpQx4fATNk7KARmFGBrdxp5L7sd1V';
        _defaultURI[209] = 'Qmc3AUMpdcpvCYLCXkBfYv9d1it2qMYBe1dkmzB37esZxr';
        _defaultURI[210] = 'QmTRpz8yMMRijzDXTceRcn6kY6zAQcunYmK5BHSLkW7Dnj';
        _defaultURI[211] = 'QmXS9zwSRkmBVqTD3kUoWK52swCYer8JbzstFHo2jEa9AD';
        _defaultURI[212] = 'QmYWJQL2Lc2mNspwEg1G6CePZiknrhAq7mQDeyA7s6K6BQ';
        _defaultURI[213] = 'QmZC6RPys1nT5BERv287phx8oHyKuSYatvrxaQui7VSQHo';
        _defaultURI[214] = 'QmPrC6fQBiDLGYt7bFo4XojbRQFfspRypG82G7RH6soAt2';
        _defaultURI[215] = 'QmNcxuFnXzcZ7ZfAaiUNxtnLVTuerLiHkVdrENsXzQbkWP';
        _defaultURI[216] = 'QmbdzraBcmNAfAZtQHBhhdr65cfK74RudfUx6H3u61PU4W';
        _defaultURI[217] = 'QmV2gTpzM1FqwTCDRHFYWXrdx4oictZYuaUzkRBppEHQjK';
        _defaultURI[218] = 'QmRGBAzt99rv8ccMpj5abKcP9q4mxB7HPuyWMwh66eXT61';
        _defaultURI[219] = 'QmUHEvG9QUYsU6rV6iqikUPPzmW2eD4cPUwakZsp5ctBsy';
        _defaultURI[220] = 'QmUnjvGwmQkdpXZdia8wRbRA44aVF5yjWu3XH63Casuprz';
        _defaultURI[221] = 'QmbpcCnHNBgjTnhp5kL3igrL7cjazjNjsvv8VfgRKSU31i';
        _defaultURI[222] = 'QmYJvTKf6iQvjvKJS7pCxhdcgCgUptsxsKCtLGPkrhdXq1';
        _defaultURI[223] = 'QmRUG85W5VxLRvFFG85YAKXeze3M7wZEJHB7KzkweR2ifC';
        _defaultURI[224] = 'QmYxA1qDomsPmxA5NYwPnRa87Th29sxhm2HGzTjDcMcPaR';
        _defaultURI[225] = 'QmQFuM7EUc2FqL7Wt978KPeSSeZ98VLYzNovoW7KeNmdSa';
        _defaultURI[226] = 'QmcYFX9Vzfsew1sMraLC3psGGVVYPgWDXAfRQkZ3AkgHz8';
        _defaultURI[227] = 'QmZCFa3CQUhPPZkTPRjrhySXVxt2o3Bngh3Pw9EAAV7t91';
        _defaultURI[228] = 'QmdRzzV3VTU2sbMuaCiLgu77DGagS7ZBWFDTsBNC8NDWPt';
        _defaultURI[229] = 'QmZvooLBqxci5SehNZrK2dSzoyZigYTUoCFxZpcQa7sQad';
        _defaultURI[230] = 'QmdmV37hh644woJeUiTLEjzWwvR1RmkQnn5WabxLkLRNqd';
        _defaultURI[231] = 'QmSifypLc4Rp9dHjezf3Nc8mmmB64q1MXi1PTPngAeCNpv';
        _defaultURI[232] = 'QmTcDBfrK9dc9Y3LYH71DCRJHoUv4PhhB2Z5jMPDchq8TL';
        _defaultURI[233] = 'QmPJ8EXjtF5XWEegrSDV1eK1eMwokhPSdi2LzKfgsFUD8v';
        _defaultURI[234] = 'QmZhuH1HMdkFbm1RoRizHWDGtdkuSmvrCKKpAUk7VUk1Zj';
        _defaultURI[235] = 'QmZGKPViy4jxkump2XVMB8zvXXknBRuHFCEGqUM6X3emLt';
        _defaultURI[236] = 'QmU5AoSNdiEPDCpx67kqu5PNGNAquyT9KSPiYcfRLXoJzs';
        _defaultURI[237] = 'QmarZcvvHYXhAkyTmGGvZJNs1qSdYUKix2mo5x3QrVscU7';
        _defaultURI[238] = 'QmefTx5HMupNZtTsDezygsL5z1zzoZMdTFJygi8PhWAVJJ';
        _defaultURI[239] = 'QmeGaZsqnGp5Jwco9u8W8zkPyXAYTw3ZxB8y6d4DfonKTp';
        _defaultURI[240] = 'QmS9XJ2Qz8jgKwDNJ3kbdGPAHivG6GNYnw1dquc1cCzFHV';
        _defaultURI[241] = 'Qmbw9Fngb9uiWovu2ACsL2c7aZGwq71GkFxUAAuACc2pnA';
        _defaultURI[242] = 'QmcewD3dXp9ynm5oDmZPVK9HWQka34NqqrHC7bDE8wNrtN';
        _defaultURI[243] = 'QmajzJSf24csrSdSMUXCSDQJgmbCSHvrS1JsNzdZK8hVj6';
        _defaultURI[244] = 'QmZqRFkvsgkcfuTP9wRAUmwGkZsn4UA8j5TrPYxNZgMUc8';
        _defaultURI[245] = 'QmcKa4i2i1JW3D1b2fjk2aQjqH89Y16YDoePLManCf1Aix';
        _defaultURI[246] = 'QmSpva83DWQdpy7vQ4J756So8s1W8oHNQifU4nuEkHrXys';
        _defaultURI[247] = 'QmPKmg5GZRoS5p1GzUjtibun1VPkB5ZT2dHik4gc5gfPJf';
        _defaultURI[248] = 'QmX6xiSdzwcitMFdA1Kbj2vXNESXCrHtpvXTDEj9QFBsWV';
        _defaultURI[249] = 'QmRRqrcWpw77C82TfZ8tCaQ7iVoXqEttybkGcxf7n55mo7';
        _defaultURI[250] = 'QmdxMZ5E8pFR6WkaA24Ye1sd5ZbeRmQPiYt8ouA1L2dLVP';
        _defaultURI[251] = 'QmejWsnUP6P4q8hLk4jeuodgTofFtVne4xgvcwShGVFNrz';
        _defaultURI[252] = 'QmTA5T6qkfR5SxULYkK3RXctTiygQJf5LTzgpz2eMf8YGX';
        _defaultURI[253] = 'QmZgNfC2yjJ3o3xBNetdmByfXAsjnWtKKoDCqnkFqvRbNg';
        _defaultURI[254] = 'QmRuPg4RUehwDp7wyqtbaCb5VPbrCmaXBqsqWASEsrBXij';
        _defaultURI[255] = 'QmW3YtYFb5oq81TW9P4oskxsvobN8hKfCEmpdMUREYpu1A';
        _defaultURI[256] = 'QmWqzzjcgP65sXjkF2xpqFwpwV4xTHtDDqNynYVNcJUcgC';
        _defaultURI[257] = 'QmdV8CD2de9e7a1JDXK49obrxPtD9BXoQyEyXPvLc2y3Yg';
        _defaultURI[258] = 'QmWD38a8xD6SN3Xj8KQCNPcrYFif7KYQKbRZLvGuMhSB5h';
        _defaultURI[259] = 'QmWiDFp8VuEUfCcY7bPRC1oit79XXUbgMFpnmjNP9L8AZF';
        _defaultURI[260] = 'QmepFmnf58L5JMWW6cqNW898s92kH3sPtXE6btRtEBQXL5';
        _defaultURI[261] = 'QmVMsZ21seazrJvzyA2m94tp15rkPRuKBRUUUhLWQNwJAw';
        _defaultURI[262] = 'QmVD7xK3XihuYMzvPYKtx7CTPoJwkkazuzT3Gui6vd6FfD';
        _defaultURI[263] = 'QmT4LdYYs3hzRV4gNjBK64A3qXLbm44RLvtrKVp1d1oxpM';
        _defaultURI[264] = 'QmcH7QNkznZaXTJR6UUxrRD6V4ssTd84xjr3JuPb2uufAv';
        _defaultURI[265] = 'QmTteRABYVZKbagLELRkZVYUXazME5hmjEPRHdek9cyaPe';
        _defaultURI[266] = 'QmSEUnah47nQ8oThBnxhNPCy134CCZxheeDYF7ZdAvVpxb';
        _defaultURI[267] = 'QmUwoZ4EhLKFRJGSoxZbu8aYMMCGvnbBwEdPzXx3d2nhWo';
        _defaultURI[268] = 'QmfS22ibWvystjJFjvud1UMXrCkNRRh8j73LkMfrMNkPPd';
        _defaultURI[269] = 'QmZ5qtJJFa4pBHap2yJmbSHmKNdA9iDThMAm6RUAREqswP';
        _defaultURI[270] = 'QmX1ZL9YJaPfoY8KfPjqB8V2jU5TU6GhqC3Zjua6KPcEZz';
        _defaultURI[271] = 'QmXaTEtM4iDD6t6t8qyEs79FS66fqJf18EjsTwRNX3ipi3';
        _defaultURI[272] = 'QmQmnxm4kKDHxMq1K1N18QgwjYKP6kHJBayzHAxQotDRtG';
        _defaultURI[273] = 'QmWyf2STxEzKCX6Nmm9o4gj1g6fd7eRgbQWj7wcktMykS2';
        _defaultURI[274] = 'QmP8bVSwR68ePfQwjUmdEeK6EPyBtLYkXrnesxcYQxFswg';
        _defaultURI[275] = 'QmYaWTYAU19WQuu65aJdLGiRezr7MSP4priWGRBJdYNf38';
        _defaultURI[276] = 'QmNWV4wefiAiw2XKukzP1pN9tQayb259aQZJefjhFQsW1Z';
        _defaultURI[277] = 'QmRAUZK1bvFmvtyk2k325pUY9T8AtppYnWp3H4KGSDShwC';
        _defaultURI[278] = 'QmUzvhhNRzjorD6TVHezcvw5wTcnLaeoAujSmFzm84nF71';
        _defaultURI[279] = 'QmaiAEwtAHw5k4keNpfhrRLjvKgb1j6YmCaSbCtU7kqsnd';
        _defaultURI[280] = 'Qmd1j1Nhvx4xVNBkSs289gzzfCBRncYRoUDZjMHikS4qsr';
        _defaultURI[281] = 'QmXWMnwLAZKB2BBkvXtruDugmNBSXMse4LfGPd4DEWA3X9';
        _defaultURI[282] = 'QmdiLDSRJQVX38pE6Z7KYkbxJaSXqp9b4Ly8nPadZUkxuu';
        _defaultURI[283] = 'QmXK5cQj7DhmKyK7vNMpTTbSa6S8QxDHyC1r1RFmyQTUJh';
        _defaultURI[284] = 'QmX1p8jNZr8t2wbybPFxkvPcFrtFbKDvDFAgBfTKXRHa3X';
        _defaultURI[285] = 'QmY7i1Q6eGM2CMW56pXTi1kzDQ67vjgtMU4EkJKBQUpkzT';
        _defaultURI[286] = 'QmR22DEd97P8sghJd26gYh2MTbEHurRWkjREU3S4w33Fyc';
        _defaultURI[287] = 'QmXjFP4zFhEKL1o8vyzpL4wtESmhWS4H7WqVJopR8cHnNx';
        _defaultURI[288] = 'QmcXgNDyLk5uNzKGx4KzKmpZazySzPboFeGh9qnAn3UU1u';
        _defaultURI[289] = 'Qmc5DxtvH7QPb4VAHhgPxGXYnbY5QrfaWKF2UY9n4CjhCa';
        _defaultURI[290] = 'QmQuYTv4Z6UcsoTvC3oUiMHr8ZvZvGV9QCin1mxsd79pR7';
        _defaultURI[291] = 'Qmb1R6rUztxThLYXPvW4Ni1ff6fbcrmuXTDZ6oyV4765ip';
        _defaultURI[292] = 'QmPUKgheXx5uAgrq1wKJMhDtAxbjGDzh3V4dkdwqRxovpg';
        _defaultURI[293] = 'Qmd3kFPG2ojCYzahyLLCBnULgDvjZkEpctCdRHjttHAcfG';
        _defaultURI[294] = 'QmVwbjRviYivpyA89ar5M7jYQR4xGSVJ4nn7v8AkfKFGBi';
        _defaultURI[295] = 'QmX6mQqY5cAJbUntyzof1TQaMqSrWTu1Bcpbmp7gcgAzCL';
    }

    // ...
}
