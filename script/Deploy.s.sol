// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import { MCDevKit } from "@devkit/MCDevKit.sol";
import { MCScript } from "@devkit/MCScript.sol";

import { ClaimReward } from "../src/main/functions/ClaimReward.sol";
import { CreateLock } from "../src/main/functions/CreateLock.sol";
import { DistributeRewards } from "../src/main/functions/DistributeRewards.sol";
import { ExecuteAdminSelection } from "../src/main/functions/ExecuteAdminSelection.sol";
import { Initialize } from "../src/main/functions/Initialize.sol";
import { RejectReportAndBan } from "../src/main/functions/RejectReportAndBan.sol";
import { ReportSafetyIssue } from "../src/main/functions/ReportSafetyIssue.sol";
import { SlashDishonestAdmin } from "../src/main/functions/SlashDishonestAdmin.sol";
import { Storage } from "../src/main/storage/Storage.sol";
import { Schema } from "../src/main/storage/Schema.sol";

contract Deployment is MCScript {
    function run() public startBroadcastWith("DEPLOYER_PRIV_KEY") {
        // Initialize the meta contract context
        mc.init("ReportDAO");

        // Use the deployed contracts with the meta contract
        mc.use("ClaimReward", ClaimReward);
        mc.use("CreateLock", CreateLock);
        mc.use("DistributeRewards", DistributeRewards);
        mc.use("ExecuteAdminSelection", ExecuteAdminSelection);
        mc.use("Initialize", Initialize);
        mc.use("RejectReportAndBan", RejectReportAndBan);
        mc.use("ReportSafetyIssue", ReportSafetyIssue);
        mc.use("SlashDishonestAdmin", SlashDishonestAdmin);
        mc.use("Storage", Storage);
        mc.use("Schema", Schema);

        // Deploy the meta contract
        address proxy = mc.deploy().toProxyAddress();
        console2.log("Meta contract deployed at:", proxy);
        
        // Initialize
        Initialize(proxy).initialize(address(0x123...)); // Example token address

        // Save the addresses to the .env file for further use
        bytes memory encodedData = abi.encodePacked(
            "PROXY_ADDR=", vm.toString(proxy), "\n"
        );
        vm.writeLine(
            string(
                abi.encodePacked(vm.projectRoot(), "/.env")
            ),
            string(encodedData)
        );
    }
}
