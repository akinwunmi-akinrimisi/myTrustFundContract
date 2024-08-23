const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");


module.exports = buildModule("MyTrustFundDistributionModule", (m) => {


  const MyTrustFundDistribution = m.contract("MyTrustFundDistribution", [], {

  });

  return { MyTrustFundDistribution };
});


