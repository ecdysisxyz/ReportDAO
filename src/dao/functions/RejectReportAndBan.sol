// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "../storage/Schema.sol";
import "../storage/Storage.sol";
import "../utils/GlobalStateLib.sol";

contract RejectReportAndBan {
    function rejectReportAndBan(address reporter, uint256 reportId) external {
        Schema.GlobalState storage s = Storage.state();
        require(!s.users[msg.sender].isBanned, "User is banned");
        require(!s.reports[reportId].isRejected, "Report already rejected");

        Schema.Report storage report = s.reports[reportId];
        require(report.reportID == reportId, "Report does not exist");

        // Add vote to reject the report
        report.votes[msg.sender] = true;

        // Count the votes
        uint256 voteCount = 0;
        for (uint256 i = 0; i < s.userList.length; i++) {
            if (report.votes[s.userList[i]]) {
                voteCount++;
            }
        }

        // Check if quorum is reached
        require(voteCount > s.quorum, "Quorum not reached");

        // Ban the reporter and mark the report as rejected
        s.users[reporter].isBanned = true;
        report.isRejected = true;

        // Update quorum
        s.quorum = calculateQuorum(s.userList);

        GlobalStateLib.activeUserCount();
        emit ReportRejected(reporter, reportId, msg.sender);
    }

    function calculateQuorum(address[] memory userList) internal view returns (uint256) {
        uint256 activeUserCount = 0;
        for (uint256 i = 0; i < userList.length; i++) {
            if (!s.users[userList[i]].isBanned && s.users[userList[i]].isActive) {
                activeUserCount++;
            }
        }
        return activeUserCount / 2;
    }

    event ReportRejected(address indexed reporter, uint256 reportId, address indexed by);
}