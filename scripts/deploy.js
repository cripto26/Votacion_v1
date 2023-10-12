const hre = require("hardhat");

async function main() {
    const [deployer] = await hre.ethers.getSigners();
    console.log("Deploying contracts with the account:", deployer.address);

    const VotingSystem = await hre.ethers.getContractFactory("Votacion");
    const votingSystem = await VotingSystem.deploy();

    console.log("VotingSystem contract deployed to:", await votingSystem.getAddress());
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
