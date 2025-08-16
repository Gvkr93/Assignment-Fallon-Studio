// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {SimpleToken} from "../src/SimpleToken.sol";

contract SimpleTokenTest is Test {
    SimpleToken public simpleToken;

    address bob = makeAddr("bob");
    address alice = makeAddr("alice");

    function setUp() public {
        simpleToken = new SimpleToken();
    }

    function testOwnerIsDeployer() public view {
        assertEq(simpleToken.owner(), address(this));
    }
}
