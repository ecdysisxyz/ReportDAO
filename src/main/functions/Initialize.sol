// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../storage/Schema.sol";
import "../storage/Storage.sol";
import "../utils/OnlyOnce.sol";

contract Initialize is OnlyOnce {
    function initialize(address tokenAddr) external onlyOnce {
        Schema.GlobalState storage s = Storage.state();
        s.tokenAddress = tokenAddr;
    }
}