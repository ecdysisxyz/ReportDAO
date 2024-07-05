// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "../storage/Schema.sol";
import "../storage/Storage.sol";
import "../utils/GlobalStateLib.sol";

contract ReportSafetyIssue {
    function reportSafetyIssue(string memory description, string memory location, bytes32 cid) external {
        Schema.GlobalState storage $s = Storage.state();
        require(!$s.users[msg.sender].isBanned, "User is banned");

        uint256 reportID = $s.nextReportID++;
        Schema.Report storage report = $s.reports[reportID];
        report.reportID = reportID;
        report.reporterID = msg.sender;
        report.description = description;
        report.location = location;
        report.cid = cid;
        report.timestamp = block.timestamp;

        $s.users[msg.sender].reportCount++;
        GlobalStateLib.updateActiveUserCount();

        emit ReportCreated(msg.sender, reportID, description, location, cid);
    }

    event ReportCreated(address indexed reporter, uint256 reportID, string description, string location, bytes32 cid);
}