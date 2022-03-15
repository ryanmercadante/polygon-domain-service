/* eslint-disable no-process-exit */
import { ethers } from "hardhat";

async function main() {
  // const [owner, randomPerson] = await ethers.getSigners();
  const domainContractFactory = await ethers.getContractFactory("Domains");
  const domainContract = await domainContractFactory.deploy("ninja");
  await domainContract.deployed();

  console.log("Contract deployed to:", domainContract.address);
  // console.log("Contract deployed by:", owner.address);

  const tx = await domainContract.register("mortal", {
    value: ethers.utils.parseEther("0.11"),
  });
  await tx.wait();

  const domainOwner = await domainContract.getAddress("mortal");
  console.log("Owner of domain:", domainOwner);

  const balance = await ethers.provider.getBalance(domainContract.address);
  console.log("Contract balance:", ethers.utils.formatEther(balance));

  // tx = await domainContract
  //   .connect(randomPerson)
  //   .setRecord("doom", "haha my domain now!");
  // await tx.wait();
}

async function runMain() {
  try {
    await main();
    process.exit(0);
  } catch (err) {
    console.error(err);
    process.exit(1);
  }
}

runMain();
