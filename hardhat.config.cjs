require("@nomicfoundation/hardhat-toolbox");

require('dotenv').config();

/** @type import('hardhat/config').HardhatUserConfig */
const { PRIVATE_KEY, INFURA_PROJECT_ID, ALCHEMY_API_KEY, ETHERSCAN_API_KEY } = process.env;

module.exports = {
  solidity: "0.8.24",
  networks: {
    sepolia: {
      url: `https://eth-sepolia.g.alchemy.com/v2/${ALCHEMY_API_KEY}`,
      accounts: [`0x${PRIVATE_KEY}`]
     }
  },
  etherscan: {
    apiKey: ETHERSCAN_API_KEY // For verifying contracts on Etherscan
  }, 
  sourcify: {
    enabled: false
  },
};




