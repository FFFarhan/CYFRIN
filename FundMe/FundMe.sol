//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

//get funds
//withdraw funds
//set minimum spend amount

contract FundMe{
    function fund() public {

    }
    function withdraw() public payable {
        //allow users to send eth
        //set min limit 
        require(msg.value > 2100000000000000, "Not Enough Eth");
    }
}
