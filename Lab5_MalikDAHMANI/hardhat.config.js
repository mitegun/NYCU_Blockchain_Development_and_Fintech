/** @type import('hardhat/config').HardhatUserConfig */

require('dotenv').config();
require("@nomiclabs/hardhat-ethers");
require("@nomicfoundation/hardhat-chai-matchers")
require('solidity-coverage');
require("hardhat-gas-reporter");
require("@nomicfoundation/hardhat-verify");

const { vars } = require("hardhat/config");

const { API_URL, PRIVATE_KEY } = process.env;




module.exports = {
   solidity: {
      version: "0.8.24",
      settings: {
        optimizer: {
          enabled: true,
          runs: 1000,
        },
      },
    },

   gasReporter: {
      enabled: process.env.REPORT_GAS ? true : true,
      maxMethodDiff: 25,
      coinmarketcap: process.env.COINMARKETCAP_API_KEY,
   },
   
   etherscan: {
      apiKey: {
         zircuit: "71A66E5B3E1C452433DBAD1834A9E87D93",
      },
      customChains: [
         {
           network: "zircuit",
           chainId: 48899,
           urls: {
             apiURL: 'https://explorer.zircuit.com/api/contractVerifyHardhat',
             browserURL: "https://explorer.zircuit.com/"
           }
         }
       ]
   

   },

   sourcify: {
      enable: true
   },

//  defaultNetwork: "sepolia",
   networks: {
     hardhat: {},
     sepolia: {
      url: "https://eth-sepolia.g.alchemy.com/v2/r__8c9ZupJJe3JSl4EojZemXuWNuyNcv",
      
   },
   zircuit: {
      url: `https://zircuit1.p2pify.com`,
      
   }
     
  },
};