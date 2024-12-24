// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LearningBadges {

    // Struct to represent a badge
    struct Badge {
        uint256 badgeId;      // Unique identifier for the badge
        string name;          // Name of the badge (e.g., "JavaScript Master")
        string metadata;      // Metadata (e.g., image URL or description)
        uint256 issuedAt;     // Timestamp when the badge was issued
    }

    // Mapping to store badge ownership by user address
    mapping(address => uint256[]) private userBadges;

    // Mapping to store badge details by badgeId
    mapping(uint256 => Badge) public badges;

    // Counter for generating unique badge IDs
    uint256 public badgeIdCounter;

    // Event to log badge issuance
    event BadgeIssued(address indexed learner, uint256 badgeId, string name);

    // Admin address to issue badges
    address public admin;

    // Modifier to allow only admin to issue badges
    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can issue badges");
        _;
    }

    // Constructor to set the admin address
    constructor() {
        admin = msg.sender;
    }

    // Function 1: Issue a badge (NFT-like) to a learner when they achieve a goal
    function issueBadge(address learner, string calldata badgeName, string calldata metadata) external onlyAdmin {
        require(bytes(badgeName).length > 0, "Badge name is required");
        require(bytes(metadata).length > 0, "Metadata is required");

        // Generate a unique badge ID
        badgeIdCounter++;

        // Create the badge struct
        Badge memory newBadge = Badge({
            badgeId: badgeIdCounter,
            name: badgeName,
            metadata: metadata,
            issuedAt: block.timestamp
        });

        // Store the badge info
        badges[badgeIdCounter] = newBadge;

        // Assign the badge to the learner
        userBadges[learner].push(badgeIdCounter);

        // Emit the BadgeIssued event
        emit BadgeIssued(learner, badgeIdCounter, badgeName);
    }

    // Function 2: Get a list of badges (badgeIds) earned by the learner
    function getBadges(address learner) external view returns (uint256[] memory) {
        return userBadges[learner];
    }

    // Function to get detailed information about a badge by its ID
    function getBadgeDetails(uint256 badgeId) external view returns (Badge memory) {
        return badges[badgeId];
    }
}
