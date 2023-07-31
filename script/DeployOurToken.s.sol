// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {OurToken} from "../src/OurToken.sol";

contract DeployOurToken is Script {
    function run() external returns (OurToken) {
        uint256 initialSupply = 1000 ether;

        vm.startBroadcast();
        OurToken ourToken = new OurToken(initialSupply);
        vm.stopBroadcast();

        return ourToken;
    }
}
