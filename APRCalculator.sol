// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

error NotOwner();

contract APRCalculator {
    address public immutable i_owner;
    address[] public APR_managers;
    uint256 public constant GENERAL_RATE = 40;
    int256[] public 1M_loan_rate;
    int256[] public 3M_loan_rate;
    int256[] public 6M_loan_rate;
    
    function addAPRManager(address _new_manager) public {
        require(msg.sender == i_owner, NotOwner);
        APR_managers.push(_new_manager);
    }

    function removeAPRManager() public {
        address[] new_APR_managers;
        for(uint256 managerIndex=0; managerIndex < APR_managers.length; managerIndex++) {
            address manager = APR_managers[managerIndex];
            if msg.sender != manager:
                new_APR_managers.push(manager);
        }
        APR_managers = new_APR_managers;
    }

    function setAPR(string duration, uint256 rating, uint256 rate) public {

    }

    function getAPR(string duration, uint256 rating) public view returns(uint256) {
        return _APR;
    }

    constructor() {
        i_owner = msg.sender;
        APR_managers.push(i_owner);
        for(rating=1; rating <= 10; rating++) {
            1M_loan_rate.push(GENERAL_RATE);
            3M_loan_rate.push(GENERAL_RATE);
            6M_loan_rate.push(GENERAL_RATE);
        }
    }
}