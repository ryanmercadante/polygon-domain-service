//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.10;

import { StringUtils } from "./libraries/StringUtils.sol";
import "hardhat/console.sol";

contract Domains {
  string public tld;

  mapping(string => address) public domains;
  mapping(string => string) public records;

  constructor(string memory _tld) payable {
    tld = _tld;
    console.log("%s name service deployed", _tld);
  }

  // A price function that will give the price of a domain based on length
  function price(string calldata name) public pure returns (uint) {
    uint len = StringUtils.strlen(name);
    require(len > 0, "Must have a name");

    if (len == 3) {
      return 5 * 10**17; // 0.5 Matic
    } else if (len == 4) {
      return 3 * 10**17; // 0.3 Matic
    } else {
      return 1 * 10**17; // 0.1 Matic
    }
  }

  // A register function that adds their names to our mapping
  function register(string calldata name) public payable {
    // Check that the name is unregistered
    require(domains[name] == address(0), "Name is already registered.");

    uint _price = price(name);

    // Check if enough Matic was paid in transaction
    require(msg.value > _price, "Not enough Matic paid");

    domains[name] = msg.sender;
    console.log("%s has registered a domain!", msg.sender);
  }

  // This will give us the domain owner's address
  function getAddress(string calldata name) public view returns (address) {
    return domains[name];
  }

  function setRecord(string calldata name, string calldata record) public {
    // Check that the owner is the transaction sender
    require(domains[name] == msg.sender, "You don't own this domain");
    records[name] = record;
  }

  function getRecord(string calldata name) public view returns (string memory) {
    return records[name];
  }
}
