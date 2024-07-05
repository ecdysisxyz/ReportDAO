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

        report.votes[msg.sender] = true;

        uint256 voteCount = 0;
        for (uint256 i = 0; i < s.userList.length; i++) {
            if (report.votes[s.userList[i]]) {
                voteCount++;
            }
        }

        require(voteCount > s.quorum, "Quorum not reached");

        s.users[reporter].isBanned = true;
        report.isRejected = true;

        s.quorum = calculateQuorum(s.userList);

        GlobalStateLib.updateActiveUserCount();
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