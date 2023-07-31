// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console2} from "forge-std/Test.sol";
import {DeployOurToken} from "../script/DeployOurToken.s.sol";
import {OurToken} from "../src/OurToken.sol";

contract OurTokenTest is Test {
    DeployOurToken deployer;
    OurToken ourToken;

    address tom = makeAddr("tom");
    address bob = makeAddr("bob");

    uint256 public constant STARTING_BALANCE = 100 ether;

    function setUp() public {
        deployer = new DeployOurToken();
        ourToken = deployer.run();
    }

    function test_TotalSupply_IsSetCorrectly() public {
        uint256 totalSupply = ourToken.totalSupply();
        assertEq(totalSupply, 1000 ether, "totalsupply");
    }

    function test_OwnerBalanceIsTotalSupply() public {
        uint256 balanceOfOwner = ourToken.balanceOf(msg.sender);
        assertEq(balanceOfOwner, 1000 ether, "ownerbalance");
    }

    function test_Transfer() public {
        // Arrange
        vm.prank(msg.sender);
        // Act
        ourToken.transfer(bob, STARTING_BALANCE);
        uint256 balanceOfBob = ourToken.balanceOf(bob);
        // Assert
        assertEq(balanceOfBob, STARTING_BALANCE, "transfer");
    }

    function test_OwnerBalanceAfter_Transfer() public {
        // Arrange
        vm.prank(msg.sender);
        // Act
        ourToken.transfer(bob, STARTING_BALANCE);
        uint256 balanceOfOwner = ourToken.balanceOf(msg.sender);
        // Assert
        assertEq(balanceOfOwner, 1000 ether - STARTING_BALANCE, "transfer");
    }

    function test_Allowance() public {
        vm.prank(msg.sender);
        ourToken.transfer(bob, STARTING_BALANCE);
        // Arrange
        uint256 initialAllowance = 10 ether;
        uint256 transferAmount = 5 ether;
        vm.prank(bob);
        // Act
        ourToken.approve(tom, initialAllowance);

        vm.prank(tom);
        ourToken.transferFrom(bob, tom, transferAmount);

        uint256 balanceOfTom = ourToken.balanceOf(tom);
        uint256 balanceOfBob = ourToken.balanceOf(bob);
        // Assert
        assertEq(balanceOfTom, transferAmount, "allowances tom");
        assertEq(
            balanceOfBob,
            STARTING_BALANCE - transferAmount,
            "allowances bob"
        );
    }
}
