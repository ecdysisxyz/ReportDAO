```mermaid
flowchart TD
    A[Start] --> B[Check if Admin is Banned]
    B -->|No| C[Check if Report Exists]
    C --> D{Does Report Exist?}
    D -->|Yes| E[Add Vote]
    E --> F[Count Votes]
    F --> G{Is Quorum Reached?}
    G -->|Yes| H[Ban Reporter]
    H --> I[Mark Report as Rejected]
    I --> J[Update Quorum]
    J --> K[Emit ReportRejected Event]
    K --> L[Reflect Global State]
    L --> M[End]
    G -->|No| N[Revert Transaction]
    N --> M
    D -->|No| O[Revert Transaction]
    O --> M
    B -->|Yes| P[Revert Transaction]
    P --> M