pragma solidity >=0.8.0 <0.9.0;
// SPDX-License-Identifier: MIT

import '@openzeppelin/contracts/token/ERC20/ERC20.sol';
import '@openzeppelin/contracts/access/Ownable.sol';

// learn more: https://docs.openzeppelin.com/contracts/3.x/erc20

contract YourToken is ERC20, Ownable {
  uint256 public constant decimal = 18;
  // ToDo: add constructor and mint tokens for deployer,

  constructor(uint256 initialSupply) public ERC20('Exo', 'WZZ') {
    // _mint() 1000 * 10 ** 18 to msg.sender
    _mint(msg.sender, initialSupply * (10 ** decimal));
  }
}
