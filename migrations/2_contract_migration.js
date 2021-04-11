const MuscleToken = artifacts.require("MuscleToken");

module.exports = async function (deployer) {
  await deployer.deploy(MuscleToken);  
};
