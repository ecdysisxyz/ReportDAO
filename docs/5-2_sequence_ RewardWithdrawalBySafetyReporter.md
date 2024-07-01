```mermaid
sequenceDiagram
    participant SafetyReporter
    participant Protocol

    SafetyReporter->>Protocol: claimReward()
    Protocol->>Protocol: Check if User is Banned
    Protocol-->>SafetyReporter: Revert Transaction (if banned)
    Protocol->>Protocol: Check User's Reward Balance
    Protocol-->>SafetyReporter: Revert Transaction (if balance <= 0)
    Protocol->>SafetyReporter: Transfer Reward to User
    Protocol->>Protocol: Reset User's Reward Balance
    Protocol->>SafetyReporter: Emit RewardClaimed Event
    Protocol->>Protocol: Reflect Global State