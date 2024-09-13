//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

//get funds
//withdraw funds
//set minimum spend amount

contract FundMe{

    uint256 public minimumUsd = 5*10e18;

    function fund() public payable  {
        require(getConversionRate(msg.value) >= minimumUsd, "Not Enough Eth");
    }
    function withdraw() public payable {
        //allow users to send eth
        //set min limit 
        
    }

    function getPrice() public view returns (uint256) {
        // Sepolia ETH / USD Address
        // https://docs.chain.link/data-feeds/price-feeds/addresses
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        );
        (, int256 answer, , , ) = priceFeed.latestRoundData();
        // ETH/USD rate in 18 digit
        return uint256(answer * 10000000000);
    }
    function getConversionRate(uint256 ethAmount) public view returns (uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e8;
        return ethAmountInUsd;
    }






}
