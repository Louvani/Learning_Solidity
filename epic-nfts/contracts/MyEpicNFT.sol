// SPDX-License-Identifier: UNLICENSES

/**
    This is the version of the Solidity compiler we want our contract to use.
    It basically says "when running this, I only want to use a Solidity
    compiler with its version 0.8.0 or higher, but not higher than 0.9.0.
    be sure your compiler is set accordingly (eg. 0.8.0) in hardhat.config.js.
 */
pragma solidity ^0.8.0;

// Import some OpenZeppelin contracts (Inheritance)
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

// Hardhat allows us to do some console logs in our contract.
import "hardhat/console.sol";

import { Base64 } from "./libraries/Base64.sol";

contract MyEpicNFT is ERC721URIStorage {
    // Magic, OpenZeppelin help us keep track of tokenIds.
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // Pass the name of the NFTs token and its symbol
    constructor() ERC721("SquareNFT", "SQUARE"){
        console.log("This is my NFT contract. Whoa!");
    }

    string baseSvg = "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 24px; }</style><rect width='100%' height='100%' fill='black' /><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>";

    string[] firstWords = ["MOUNTAIN", "OCEAN", "SNOW", "PRIDE", "PHOTOGRAPH", "MUSIC"];
    string[] secondWords = ["BRAVE", "ADVENTUROUS", "ARROGANT", "CLEVER", "FANCY", "FUNNY"];
    string[] thirdWords = ["KINDLY", "JEALOUSLY", "NEARLY", "RUDELY", "SHILVY", "SUDDENLY"];

    function pickRandom(uint256 tokenId, string[] memory listOfWords) public pure returns (string memory) {
        uint256 rand = random(string(abi.encodePacked("MIXING_WORDS", Strings.toString(tokenId))));
        rand = rand % listOfWords.length;
        return listOfWords[rand];
    }

    function random(string memory input) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(input)));
    }

    // Function that the user hit to get the NFT
    function makeAnEpicNFT() public {
        //get the current ID that starts at 0
        uint256 newItemId = _tokenIds.current();
        console.log("\n--------------------");

        string memory first = pickRandom(newItemId, firstWords);
        string memory second = pickRandom(newItemId, secondWords);
        string memory third = pickRandom(newItemId, thirdWords);

        string memory combinedWord = string(abi.encodePacked(first, second, third));
        string memory finalSvg = string(abi.encodePacked(baseSvg, combinedWord, "</text></svg>"));

        string memory json = Base64.encode(
            bytes(string(abi.encodePacked(
                '{"name": "',
                combinedWord,
                '", "description": "A highly acclaimed collection of words.", "image": "data:image/svg+xml;base64,',
                Base64.encode(bytes(finalSvg)),
                '"}'
            )))
        );

        string memory finaltokenURI = string(abi.encodePacked("data:application/json;base64,", json));


        console.log("\n--------------------");
        console.log(finaltokenURI);
        console.log("--------------------\n");
        /** Mint the NFT to the sender using msg.sender addres
         * msg.sender is a variable Solidity itself provides
         * that easily gives us access to the public address
         * of the person calling the contract.
        */
        _safeMint(msg.sender, newItemId);

        // Set the NFTs data
        _setTokenURI(newItemId, finaltokenURI);

        // Increment the counter for the next NFT
        _tokenIds.increment();
        console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);
    }
}
