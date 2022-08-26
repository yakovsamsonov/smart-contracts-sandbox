// SPDX-License-Identifier: MIT
pragma solidity 0.8.8;

contract SimpleStorage {
    // main data types: boolean, uint, sting, int, address, bytes
    bool hasFavoriteNumber = true;
    uint256 public favoriteNumber = 123; //uint means uint256 by default
    string favoriteNumberInText = "five";
    int256 favoriteInt = -5;
    bytes32 favoriteBites = "cat";

    uint256 favoriteNumber2; // initialized with 0

    People public people = People({favoriteNumber: 2, name: "Patrick"});

    struct People {
        uint256 favoriteNumber;
        string name;
    }

    function store(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
    }

    // view and pure functions doesn't cost gas to run
    // view - reads blockchain state, pure - doesn't use blockchain at all 
    function retrieve() public view returns(uint256) {
        return favoriteNumber;
    }

    constructor() {
        
    }
}