
// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.7.0;

import {Script} from "forge-std/Script.sol";
import {Fallout} from "../src/Fallout.sol";

contract DeployFallout is Script {

    Fallout fallout;

    function run() external returns(Fallout) {
        vm.startBroadcast();
        fallout = new Fallout();
        vm.stopBroadcast();
        return fallout;
    }

}