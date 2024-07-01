```mermaid
sequenceDiagram
    participant SafetyReporter
    participant TokenContract
    participant Protocol

    SafetyReporter->>TokenContract: approve(address(this), amount)
    SafetyReporter->>Protocol: createLock(amount, unlockTime)
    Protocol->>Protocol: Check if User is Banned
    Protocol-->>SafetyReporter: Revert Transaction (if banned)
    Protocol->>TokenContract: Check Allowance
    Protocol-->>SafetyReporter: Revert Transaction (if allowance < amount)
    Protocol->>TokenContract: transferFrom(msg.sender, address(this), amount)
    Protocol-->>SafetyReporter: Revert Transaction (if transfer fails)
    Protocol->>Protocol: Lock Tokens in Contract
    Protocol->>Protocol: Store Lock Data
    Protocol->>SafetyReporter: Emit LockCreated Event
    Protocol->>Protocol: Reflect Global State