```mermaid
stateDiagram-v2
    [*] --> Inactive
    Inactive --> Active : Activate()
    Active --> Banned : Ban()
    Active --> HighStake : achieveHighStake()
    Active --> Rejected : rejectReport()
    HighStake --> Banned : Ban()
    HighStake --> Rejected : rejectReport()
    Rejected --> Banned : Ban()
    Rejected --> Active : clearRejection()
    Banned --> [*]