// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;  //State the version

contract SimpleStorage{
    // basic types: boolean, uint(unsigned +ve whole number), int, address, bytes
    // functions and variables are internal(Not Visible) by default.
    // they can be public, private, internal, external (called via this.function_name)
    uint256 public myFavouriteNumber;   
    uint256[] listOfFavouriteNumbers;    // make lists using uint256[]
    struct Person{
        uint256 favouriteNumber;
        string name;
    }
    // Person public myFriend = Person(7, "Pat");
    // Person public mariah = Person(9, "MiahAr");
    Person[] public listOfPeople;   //dynamic, add a number in the [] to make it static
    
    mapping(string => uint256) public nameToFavouriteNumbers;



    function store(uint256 _favouriteNumber) public {
    myFavouriteNumber = _favouriteNumber;
    
   }

   function retrieve() public view returns (uint256){
    return myFavouriteNumber;
   }

    function addPerson(string memory _name, uint256 _favouriteNumber) public {
        Person memory newPerson = Person(_favouriteNumber, _name);
        listOfPeople.push(newPerson);
        nameToFavouriteNumbers[_name] = _favouriteNumber;
        // listOfPeople.push(Person(_favouriteNumber, _name);   //Works same as above
        // calldata and memory exis only for the call i.e they are temporary variables
        //memory can be manipulated, calldata cannot be modified
        //storage is perm and can be modified. cant add storage to functions
    }



}