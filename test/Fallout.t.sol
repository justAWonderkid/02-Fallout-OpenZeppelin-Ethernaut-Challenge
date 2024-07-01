
// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.7.0;

import {Test, console2} from "forge-std/Test.sol";s
import {DeployFallout} from "../script/DeployFallout.s.sol";
import {Fallout} from "../src/Fallout.sol";

contract FalloutTest is Test {

    Fallout fallout;
    DeployFallout deployer;

    address private owner = makeAddr("owner");
    address private user = makeAddr("user");


    function setUp() external {
        deployer = new DeployFallout();
        fallout = deployer.run();
        vm.deal(owner, 1 ether);
        vm.deal(user, 1 ether);
    }

    function testFal1outfunction() external {
        vm.startPrank(owner);
        fallout.Fal1out{value: 0.01 ether}();
        assertEq(owner, fallout.owner());
        assertEq(0.01 ether, fallout.allocatorBalance(owner));
        vm.stopPrank();
    }

}