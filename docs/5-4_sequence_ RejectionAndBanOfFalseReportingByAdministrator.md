```mermaid
sequenceDiagram
    participant Administrator
    participant Protocol
    participant SafetyReporter

    Administrator->>Protocol: rejectReportAndBan(reporter, reportId)
    Protocol->>Protocol: Check if Admin is Banned
    Protocol-->>Administrator: Revert Transaction (if banned)
    Protocol->>Protocol: Check if Report Exists
    Protocol-->>Administrator: Revert Transaction (if report does not exist)
    Protocol->>Protocol: Add Vote
    Protocol->>Protocol: Count Votes
    Protocol->>Protocol: Check if Quorum is Reached
    Protocol-->>Administrator: Revert Transaction (if quorum not reached)
    Protocol->>SafetyReporter: Ban Reporter
    Protocol->>Protocol: Mark Report as Rejected
    Protocol->>Protocol: Update Quorum
    Protocol->>Administrator: Emit ReportRejected Event
    Protocol->>Protocol: Reflect Global State