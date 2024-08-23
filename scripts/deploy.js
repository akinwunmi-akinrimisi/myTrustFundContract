// import { ethers } from 'hardhat';
import pkg from 'hardhat';
const { ethers } = pkg;

async function main() {

    const myTrustFundDistribution = await ethers.deployContract('MyTrustFundDistribution');

    await myTrustFundDistribution.waitForDeployment();

    console.log('MyTrustFundDistribution Contract Deployed at ' + myTrustFundDistribution.target);
}

// this pattern is recommended to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});