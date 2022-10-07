const hre = require("hardhat");

async function main() {
  // initial Supply for tokens to be minted
  const initialSupply = hre.ethers.utils.parseEther("100");

  // Contract deploy
  const Inheritance = await hre.ethers.getContractFactory("Inheritance");
  const Contract = await Inheritance.deploy(initialSupply);
  await Contract.deployed();

  console.log(`Contract deployed to ${Contract.address}`);
  await Contract.deployTransaction.wait(3);

  console.log("Verifying contract...");

  // My contract verified after 5 tries

  await hre.run("verify:verify", {
    address: Contract.address,
    constructorArguments: [initialSupply],
    contract: "contracts/Inheritance.sol:Inheritance",
  });
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
