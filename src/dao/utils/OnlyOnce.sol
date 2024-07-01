// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "../storage/Schema.sol";
import "../storage/Storage.sol";

contract OnlyOnce {
    modifier onlyOnce() {
        Schema.GlobalState storage s = Storage.state();
        require(!s.initialized, "Already initialized");
        s.initialized = true;
        _;
    }
}