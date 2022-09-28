// Get funds from users
// Withdraw funds
// Set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./PriceConverter.sol";

error NotOwner();

contract FundMe {
    using PriceConverter for uint256;

    uint256 public constant MINIMUM_USD = 50 * 1e18;

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    address public immutable i_owner;

    function fund() public payable {
        // Want to be able to set a minimum fund amount in USD
        // 1. How do we send ETH to this contract?
        require(msg.value.getConversionRate() >= MINIMUM_USD, "Didn't send enough"); // 1e18 == 1 * 10 ** 18 == 1 ETH
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
        // 18 decimals
    }

    function withdraw() public onlyOwner {
        /* starting index, ending index, step amount */
        for(uint256 funderIndex=0; funderIndex < funders.length; funderIndex++) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        // reset the array
        funders = new address[](0);

        //withdraw funds
        //transfer throws exception if above gas limit 2300
        //transfer works only with payable addresses
        //payable(msg.sender).transfer(address(this).balance);

        //send returns bool
        //bool sendSuccess = payable(msg.sender).send(address(this).balance);
        //require(sendSuccess, "Send failed");

        //call
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");        
    }

    constructor() {
        i_owner = msg.sender;  
    }

    modifier onlyOwner {
        require(msg.sender == i_owner, "Sender is not owner");
        // if (msg.sender != i_owner) { revert NotOwner(); } more gas effecient
        _;        
    }

    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }
}