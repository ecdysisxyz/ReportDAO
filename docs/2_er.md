```mermaid
erDiagram
    USER {
        address userID PK
        bool isBanned
        uint256 stakeAmount
        uint256 reportCount
        bool isActive
        uint256 lastActiveTimestamp
    }
    
    REPORT {
        uint256 reportID PK
        address reporterID FK
        string description
        string location
        bytes32 cid
        bool isRejected
        bool isBanSuggested
        uint256 timestamp
        mapping(address => bool) votes
    }

    ADMIN {
        uint256 adminID PK
        address userID FK
        uint256 stakeAmount
    }

    REJECT {
        uint256 rejectID PK
        address rejectorID FK
        uint256 reportID FK
        address adminID FK
        bool isSuccessful
        uint256 timestamp
    }

    REWARD {
        uint256 rewardID PK
        address userID FK
        uint256 amount
        uint256 timestamp
    }

    USER ||--o{ REPORT : "submits"
    USER ||--o{ ADMIN : "can become"
    USER ||--o{ REJECT : "can initiate"
    USER ||--o{ REWARD : "receives"
    REPORT ||--|{ USER : "reported by"
    REJECT ||--|{ REPORT : "rejects"
    REJECT ||--|{ USER : "initiated by"
    REJECT ||--|{ ADMIN : "against"