// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe {

    uint256 public minimumUsd = 5 * 1e18; // Minimum USD in 18 decimals

    // This function allows users to send ETH to the contract.
    function fund() public payable {
        uint256 conversionRate = getConversionRate(msg.value);
        require(conversionRate >= minimumUsd, "Not Enough ETH");
    }

    // This function allows the contract owner to withdraw all the ETH from the contract.
    function withdraw() public {
        payable(msg.sender).transfer(address(this).balance);
    }

    // Internal function to get the latest price from the Chainlink price feed.
    function getPrice() public view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306 // Sepolia ETH/USD Address
        );
        (, int256 answer, , , ) = priceFeed.latestRoundData();
        require(answer > 0, "Invalid price data");
        return uint256(answer); // Price is in 8 decimal places
    }

    // Public function to convert ETH to USD based on the latest price.
    function getConversionRate(uint256 ethAmount) public view returns (uint256) {
        uint256 ethPrice = getPrice();
        // Convert ETH amount to USD using the correct decimal scaling
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e8; // Correct decimal places
        return ethAmountInUsd;
    }
}
