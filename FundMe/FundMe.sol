//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {PriceConverter} from "./PriceConverter.sol";
//get funds
//withdraw funds
//set minimum spend amount

contract FundMe{

    using PriceConverter for uint256;
    address public immutable i_owner;
    uint256 public constant MINIMUMUSD = 5e18;
    error NotOwner();

address[] public funders;
mapping(address funder=>uint256 amount ) public addressToAmountFunded;

constructor(){
    i_owner = msg.sender;
}


    function fund() public payable  {
        require(msg.value.getConversionRate() >= MINIMUMUSD, "didnt send enough ETH");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender]  = addressToAmountFunded[msg.sender] + msg.value;
    }

    modifier onlyOwner(){
    
    if (msg.sender != i_owner){
            revert NotOwner();
        }
    _;
    }

    function withdraw() public onlyOwner {
        //allow users to send eth
        //set min limit 
        // require(msg.sender == i_owner, "Must be owner");   // added as a modifier
        for(uint256 fundersIndex = 0; fundersIndex < funders.length; fundersIndex++){
            address funder = funders[fundersIndex];
            addressToAmountFunded[funder] = 0;
        }
        //reset the array by making a new one
        funders = new address[](0);

        // //transfer
        // payable(msg.sender).transfer(address(this).balance);
        // //send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send failed");

//call is preffered over transfer and send in most places

        //call
        (bool callSuccess, ) = payable (msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call Failed");
        
        
    }
    
receive() external payable { 
    fund();
}

fallback() external payable {
    fund();
 }

}
