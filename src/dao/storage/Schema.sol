// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

library Schema {
    struct GlobalState {
        mapping(address => User) users;
        mapping(uint256 => Report) reports;
        mapping(address => Admin) admins;
        mapping(uint256 => Reject) rejects;
        mapping(address => Reward) rewards;
        uint256 nextReportID;
        uint256 nextRejectID;
    }

    struct User {
        bool isBanned;
        uint256 stakeAmount;
        uint256 reportCount;
    }

    struct Report {
        uint256 reportID;
        address reporterID;
        string description;
        string location;
        bytes32 cid;
        bool isRejected;
        bool isBanSuggested;
        uint256 timestamp;
    }

    struct Admin {
        address userID;
        uint256 stakeAmount;
    }

    struct Reject {
        uint256 rejectID;
        address rejectorID;
        uint256 reportID;
        address adminID;
        bool isSuccessful;
        uint256 timestamp;
    }

    struct Reward {
        address userID;
        uint256 amount;
        uint256 timestamp;
    }
}