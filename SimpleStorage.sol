// SPDX-License-Identifier: MIT
pragma solidity 0.8.8;

contract SimpleStorage {
    // main data types: boolean, uint, sting, int, address, bytes
    bool hasFavoriteNumber = true;
    uint256 favoriteNumber = 123; //uint means uint256 by default
    string favoriteNumberInText = "five";
    int256 favoriteInt = -5;
    bytes32 favoriteBites = "cat";

    uint256 favoriteNumber2; // initialized with 0

    mapping(string => uint256) public nameToFavoriteNumber;

    struct People {
        uint256 favoriteNumber;
        string name;
    }

    //uint256[] public favoriteNumbersList
    People[] public people;

    // virtual keyword allows to override in child contract
    function store(uint256 _favoriteNumber) virtual public {
        favoriteNumber = _favoriteNumber;
    }

    // view and pure functions doesn't cost gas to run
    // view - reads blockchain state, pure - doesn't use blockchain at all 
    function retrieve() public view returns(uint256) {
        return favoriteNumber;
    }

    // calldata memory storage
    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        People memory newPerson = People({favoriteNumber: _favoriteNumber, name: _name});
        people.push(newPerson);    
        nameToFavoriteNumber[_name] = _favoriteNumber;    
    }

    constructor() {
        
    }
}