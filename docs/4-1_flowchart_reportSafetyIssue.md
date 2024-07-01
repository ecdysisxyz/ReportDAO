```mermaid
flowchart TD
    A[Start] --> B[Check if User is Banned]
    B -->|No| C[Generate Report ID]
    C --> D[Store Report Data]
    D --> E[Increment User's Report Count]
    E --> F[Emit ReportCreated Event]
    F --> G[Reflect Global State]
    G --> H[End]
    B -->|Yes| I[Revert Transaction]
    I --> H