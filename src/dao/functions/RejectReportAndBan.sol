// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "../storage/Schema.sol";
import "../storage/Storage.sol";

contract RejectReportAndBan {
    function rejectReportAndBan(address reporter, uint256 reportId) external {
        Schema.GlobalState storage s = Storage.state();
        require(!s.users[msg.sender].isBanned, "Admin is banned");

        Schema.Report storage report = s.reports[reportId];
        require(report.reportID == reportId, "Report does not exist");

        s.users[reporter].isBanned = true;
        report.isRejected = true;

        emit ReportRejected(reporter, reportId);
    }

    event ReportRejected(address indexed reporter, uint256 reportId);
}