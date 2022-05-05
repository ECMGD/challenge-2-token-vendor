pragma solidity >=0.8.0 <0.9.0;
// SPDX-License-Identifier: MIT

import '@openzeppelin/contracts/access/Ownable.sol';
import './YourToken.sol';

contract Vendor is Ownable{
  YourToken public yourToken;
  uint256 public balance;
  uint256 public constant tokensPerEth = 1000;
  bool public liquidityDrain = false;


  constructor(address tokenAddress) public {
    yourToken = YourToken(tokenAddress);
  }

  event BuyTokens(address buyer, uint256 amountOfEth, uint256 amountOfTokens);

  function toggleDrain() public onlyOwner() returns(bool){
    liquidityDrain = !liquidityDrain;
    return liquidityDrain;
  }

  // ToDo: create a payable buyTokens() function:
  function buyTokens() public payable {
    uint256 purchase = msg.value * tokensPerEth;
    yourToken.transfer(msg.sender, purchase);
    balance = (balance + msg.value);

    emit BuyTokens(msg.sender, msg.value, purchase);
  }

  // ToDo: create a withdraw() function that lets the owner withdraw ETH
  function withdraw(uint256 amount) public onlyOwner() returns (bool){
    require(liquidityDrain, "Vendor: Liquidity drain is off.");
    require(balance >= amount, "Vendor: Insufficient contract balance");
    payable(msg.sender).transfer(amount);
    balance = (balance - amount);
    return true;
  }

  // ToDo: create a sellTokens() function:
  function approve(address addr, uint256 amount) public {
    yourToken.approve(addr, amount);
  }
  function sellTokens(uint256 amount) public {
    uint256 ethTransfer = amount * tokensPerEth;
    require(address(this).balance >= ethTransfer, "Vendor: Contract balance insufficient.");
    yourToken.transferFrom(msg.sender, address(this), amount);
    payable(msg.sender).transfer(ethTransfer);
  }
}
