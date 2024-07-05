// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {Schema} from "./Schema.sol";

// cast index-erc7201 ecdysisxyz.reportdao.globalstate
library Storage {
    function state() internal pure returns(Schema.GlobalState storage s) {
        assembly { s.slot := 0xaa03ac2ea6d7f9d0d6550bebd3c02ab4d9cabe3126f8408c25c1c4622a6dad00 }
    }
}
