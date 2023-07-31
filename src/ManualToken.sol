// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract ManualToken {
    mapping(address user => uint256 balance) private s_balances;

    function name() public pure returns (string memory) {
        return "Manual Token";
    }

    function decimals() public pure returns (uint8) {
        return 18;
    }

    function totalSupply() public pure returns (uint256) {
        return 100 ether;
    }

    function balanceOf(address _owner) public view returns (uint256) {
        return s_balances[_owner];
    }

    function transfer(
        address _to,
        uint256 _value
    ) public returns (bool success) {
        if (s_balances[msg.sender] <= _value) {
            revert();
        }
        s_balances[msg.sender] = s_balances[msg.sender] - _value;
        s_balances[_to] = s_balances[_to] + _value;
        return true;
    }
}
