```mermaid
sequenceDiagram
    participant SafetyReporter
    participant Protocol

    SafetyReporter->>Protocol: reportSafetyIssue(description, location, cid)
    Protocol->>Protocol: Check if User is Banned
    Protocol-->>SafetyReporter: Revert Transaction (if banned)
    Protocol->>Protocol: Generate Report ID
    Protocol->>Protocol: Store Report Data
    Protocol->>Protocol: Increment User's Report Count
    Protocol->>SafetyReporter: Emit ReportCreated Event
    Protocol->>Protocol: Reflect Global State