```mermaid
graph TD
    A[Safety Reporter]
    B[Administrator]
    C[Rejector]
    D[Keeper]
    E[Protocol]
    I[Deployer]

    A -->|Report Safety Issue| E
    A -->|Claim Reward| E
    A -->|Create Lock| E
    B -->|Reject Report and Ban| E
    C -->|Slash Dishonest Admin| E
    D -->|Execute Admin Selection| E
    D -->|Distribute Rewards| E
    I -->|Initialize Protocol| E

    E -->|Honor and Profit| A
    E -->|Maintain Integrity| B
    E -->|Ensure Fair Management| C
    E -->|Operational Rewards| D
    I -->|Set Token Address| E

    %% Additional actions for Create Lock and Slash Dishonest Admin
    A -->|Approve Tokens| T
    T -->|Create Lock| E
    C -->|Slash and Burn Tokens| T2
    T2 -->|Slash Dishonest Admin| E
```

## Deployer
### initalize
function initialize(address tokenAddr) external onlyOnce

## Safety Reporters
### take and report a photo
function reportSafetyIssue(string memory description, string memory location, bytes memory photo) external;
### claim Reward
function claimReward() external;
### create Deposit
function createLock(uint amount, uint unlockTime) external;

## admin.
### rejectReportAndBan(address)
function rejectReportAndBan(address reporter, uint256 reportId) external;

## rejectReportAndBan function

### specify dishonest admin and slash
function slashDishonestAdmin(address admin) external;

## keeper.

### execute admin determination function
function executeAdminSelection() external;
### Execute reward distribution function
function distributeRewards() external;