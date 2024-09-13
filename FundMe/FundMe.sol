//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
import {PriceConverter} from "./PriceConverter.sol";
//get funds
//withdraw funds
//set minimum spend amount

contract FundMe{

    uint256 public minimumUsd = 5e18;

address[] public funders;
mapping(address funder=>uint256 amount ) public addressToAmountFunded;


    function fund() public payable  {
        require(getConversionRate(msg.value) >= minimumUsd, "Not Enough Eth");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender]  = addressToAmountFunded[msg.sender] + msg.value;
    }
    function withdraw() public payable {
        //allow users to send eth
        //set min limit 
        
    }

    






}
