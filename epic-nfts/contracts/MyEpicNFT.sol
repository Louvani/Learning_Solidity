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


contract MyEpicNFT is ERC721URIStorage {
    // Magic, OpenZeppelin help us keep track of tokenIds.
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // Pass the name of the NFTs token and its symbol
    constructor() ERC721("SquareNFT", "SQUARE"){
        console.log("This is my NFT contract. Whoa!");
    }

  string baseSvg = "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 24px; }</style><rect width='100%' height='100%' fill='black' /><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>";
    
    // Function that the user hit to get the NFT
    function makeAnEpicNFT() public {
        //get the current ID that starts at 0
        uint256 newItemId = _tokenIds.current();

        /** Mint the NFT to the sender using msg.sender addres
         * msg.sender is a variable Solidity itself provides
         * that easily gives us access to the public address
         * of the person calling the contract.
        */
        _safeMint(msg.sender, newItemId);

        // Set the NFTs data
        _setTokenURI(newItemId, "data:application/json;base64,eyJuYW1lIjoiTHVjaWVybmFnYSIsImRlc2NyaXB0aW9uIjoiVW5hIG1pcmFkYSIsImltYWdlIjoiZGF0YTppbWFnZS9zdmcreG1sO2Jhc2U2NCxQSE4yWnlCM2FXUjBhRDBpTXpVd0lpQm9aV2xuYUhROUlqTTFNQ0lnZG1sbGQwSnZlRDBpTUNBd0lETTFNQ0F6TlRBaUlHWnBiR3c5SW01dmJtVWlJSGh0Ykc1elBTSm9kSFJ3T2k4dmQzZDNMbmN6TG05eVp5OHlNREF3TDNOMlp5SStDaUFnSUNBOGMzUjViR1UrTG1KaGMyVWdleUJtYVd4c09pQnZiR2wyWlRzZ1ptOXVkQzFtWVcxcGJIazZJSE5sY21sbU95Qm1iMjUwTFhOcGVtVTZJRFF3Y0hnN0lIMDhMM04wZVd4bFBnb2dJQ0FnUEhKbFkzUWdkMmxrZEdnOUlqRXdNQ1VpSUdobGFXZG9kRDBpTVRBd0pTSWdabWxzYkQwaVlteGhZMnNpSUM4K0NpQWdJQ0E4ZEdWNGRDQjRQU0kxTUNVaUlIazlJalExSlNJZ1kyeGhjM005SW1KaGMyVWlJR1J2YldsdVlXNTBMV0poYzJWc2FXNWxQU0p0YVdSa2JHVWlJSFJsZUhRdFlXNWphRzl5UFNKdGFXUmtiR1VpUGt4MVkybGxjbTVoWjJFOEwzUmxlSFErQ2p3dmMzWm5QZ289In0=");
        console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);

        // Increment the counter for the next NFT
        _tokenIds.increment();
    }
}
