import { DeployFunction } from 'hardhat-deploy/types';
import { parseEther } from 'ethers/lib/utils';
import { HardhatRuntimeEnvironmentExtended } from 'helpers/types/hardhat-type-extensions';
import { ethers } from 'hardhat';

const func: DeployFunction = async (hre: HardhatRuntimeEnvironmentExtended) => {
  const { getNamedAccounts, deployments } = hre as any;
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();

  // You might need the previously deployed yourToken:
  const yourToken = await ethers.getContract('YourToken', deployer);

  // Todo: deploy the vendor

  await deploy('Vendor', {
    // Learn more about args here: https://www.npmjs.com/package/hardhat-deploy#deploymentsdeploy
    from: deployer,
    args: [yourToken.address],
    log: true,
    gasLimit: 10000000,
  });

  const vendor = await ethers.getContract("Vendor", deployer);
  await yourToken.transfer(vendor.address, ethers.utils.parseEther("1000"));
  // await yourToken.totalSupply().then(async (r: any) => { if (r > 0) { await yourToken.burn(yourToken.address, r) } });
  console.log("\n 🏵  Sending all tokens to the vendor...\n");

  await vendor.transferOwnership(deployer);
};
export default func;
func.tags = ['Vendor'];
