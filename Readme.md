# Learning Badges dApp

This is a decentralized application (dApp) that allows an **admin** to issue badges to **learners** based on their achievements. The badges are stored on the Ethereum blockchain, and learners can view their earned badges directly from the blockchain.

## Overview

The **Learning Badges** contract is a smart contract deployed on the Ethereum network that allows an admin to issue badges to learners. These badges are associated with a learner's address and include metadata (such as an image URL or description). The dApp provides a frontend interface where the admin can issue badges to learners, and learners can view the badges they have earned.

### Features

- **Admin**: Can issue badges to learners.
- **Learner**: Can view the badges they have earned.
- **Blockchain**: All badges are stored on the Ethereum blockchain, ensuring transparency and security.
- **MetaMask**: The dApp integrates with MetaMask for wallet management and transaction signing.

## Contract Functions

1. **`issueBadge(address learner, string badgeName, string metadata)`**:

   - Issues a new badge to a learner.
   - Only accessible by the **admin**.

2. **`getBadges(address learner)`**:

   - Retrieves the list of badge IDs earned by a learner.

3. **`getBadgeDetails(uint256 badgeId)`**:

   - Retrieves the detailed information of a badge by its unique badge ID.

4. **Events**:
   - **`BadgeIssued(address learner, uint256 badgeId, string name)`**: Emitted when a badge is issued to a learner.

## Frontend Overview

The frontend allows the **admin** to issue badges and **learners** to view their earned badges.

### Core Features of the Frontend:

1. **Issue Badge**:

   - The **admin** can issue a badge by entering a badge name, metadata (such as a description or an image URL), and the learner's Ethereum address.

2. **View Badges**:
   - **Learners** can view the badges they have earned, including detailed information about the badge.

### Requirements

- **Web3.js**: To interact with the Ethereum blockchain.
- **MetaMask**: A browser extension to manage Ethereum wallets and sign transactions.
- **Ether**: Needed for gas fees if deploying on the Ethereum mainnet or test networks.

## Installation

### Prerequisites:

- **MetaMask**: Install the MetaMask extension in your browser.
- **Ethereum Network**: The contract must be deployed to a network such as **Rinkeby**, **Ropsten**, or **Ethereum Mainnet**.
- **Web3.js**: Included in the frontend through CDN.

### Steps to Deploy:

1. **Deploy the Smart Contract**:

   - Deploy the `LearningBadges` contract to an Ethereum network.
   - Ensure that the **admin** address is set correctly in the contract.

2. **Replace Contract Address**:

   - In the `index.html` JavaScript code, replace the `contractAddress` with the address of your deployed contract.

3. **Host the Frontend**:
   - Open the `index.html` file in any modern browser to interact with the dApp.
   - Alternatively, you can host it on a static file server (like GitHub Pages or Netlify).

### Interacting with the dApp:

1. **Connect MetaMask**:
   - Ensure MetaMask is connected to the Ethereum network where the contract is deployed.
2. **Issue Badge (Admin)**:

   - Enter the learner's address, badge name, and metadata (description or image URL).
   - Click the "Issue Badge" button to issue the badge.

3. **View Badges (Learner)**:
   - Click the "View My Badges" button to see the list of badges earned by the learner.

## Example Usage

- **Admin**:

  - Issues a badge such as `"JavaScript Master"` to a learner with a URL to the learner's certificate image as metadata.
  - Issues the badge by providing the learner's address, badge name, and metadata.

- **Learner**:
  - Learners can see their badges listed, including metadata (e.g., image URL or badge description) and the timestamp when the badge was issued.

## Dependencies

- **Web3.js**:

  - A JavaScript library to interact with the Ethereum blockchain.
  - Integrated via CDN in the frontend (`https://cdn.jsdelivr.net/npm/web3@1.7.1/dist/web3.min.js`).

- **MetaMask**:
  - A cryptocurrency wallet and gateway to blockchain apps. It's required for connecting to the Ethereum network.

## Contract Code

The smart contract code for the **LearningBadges** contract is as follows:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LearningBadges {

    // Struct to represent a badge
    struct Badge {
        uint256 badgeId;
        string name;
        string metadata;
        uint256 issuedAt;
    }

    mapping(address => uint256[]) private userBadges;
    mapping(uint256 => Badge) public badges;

    uint256 public badgeIdCounter;
    address public admin;

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can issue badges");
        _;
    }

    constructor() {
        admin = msg.sender;
    }

    function issueBadge(address learner, string calldata badgeName, string calldata metadata) external onlyAdmin {
        require(bytes(badgeName).length > 0, "Badge name is required");
        require(bytes(metadata).length > 0, "Metadata is required");

        badgeIdCounter++;

        Badge memory newBadge = Badge({
            badgeId: badgeIdCounter,
            name: badgeName,
            metadata: metadata,
            issuedAt: block.timestamp
        });

        badges[badgeIdCounter] = newBadge;
        userBadges[learner].push(badgeIdCounter);

        emit BadgeIssued(learner, badgeIdCounter, badgeName);
    }

    function getBadges(address learner) external view returns (uint256[] memory) {
        return userBadges[learner];
    }

    function getBadgeDetails(uint256 badgeId) external view returns (Badge memory) {
        return badges[badgeId];
    }

    event BadgeIssued(address indexed learner, uint256 badgeId, string name);
}
```

## License

This project is licensed under the **MIT License**. See the LICENSE file for more information.

## Acknowledgments

- **Ethereum**: The underlying blockchain technology that powers this decentralized application.
- **MetaMask**: A popular Ethereum wallet and gateway to blockchain apps.
- **Web3.js**: A library for interacting with the Ethereum blockchain.

---

This README file provides an overview and usage instructions for the **LearningBadges** dApp. The frontend allows interaction with the **LearningBadges** smart contract deployed on an Ethereum blockchain, facilitating badge issuance and management in a decentralized manner.
