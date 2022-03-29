const main = async () => {
    /** 1. Compile contract and generate the necessary files under the artifacts directory.*/
    const nftContractFactory = await hre.ethers.getContractFactory('MyEpicNFT');
    /** 2. Hardhat will create a local Ethereum network for us, but just for this contract.*/
    const nftContract = await nftContractFactory.deploy();
    /** 3. wait until our contract is officially mined and deployed to our local blockchain! */
    await nftContract.deployed();
    console.log("Contract deployed to:", nftContract.address);

    // // Call the function
    // let txn = await nftContract.makeAnEpicNFT()
    // await txn.wait()
    // console.log("Minted NFT #1")

    // txn = await nftContract.makeAnEpicNFT()
    // await txn.wait()
    // console.log("Minted NFT #2")
};

const runMain = async () => {
    try {
        await main();
        process.exit(0);
    } catch (error) {
        console.log(error);
        process.exit(1);
    }
};

runMain();
