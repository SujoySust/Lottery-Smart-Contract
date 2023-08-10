# Lottery Smart Contract

A simple decentralized lottery smart contract built using Solidity and Ethereum blockchain.

## Table of Contents

- [Introduction](#introduction)
- [Smart Contract Overview](#smart-contract-overview)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Running Tests](#running-tests)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Introduction

This project demonstrates the implementation of a basic lottery smart contract on the Ethereum blockchain. The contract allows users to enter the lottery by sending a specified amount of Ether and pick a random winner among the participants.

## Smart Contract Overview

The `Lottery` smart contract includes the following functionalities:

- Players can enter the lottery by sending a minimum amount of Ether.
- The contract owner can pick a winner randomly from the list of participants.
- The winner receives the total balance of the contract.
- The contract keeps track of the lottery history, including winner addresses.

## Getting Started

### Prerequisites

- Node.js and npm
- Truffle suite (used for testing and deployment)
- Ganache or another Ethereum development blockchain

### Installation

1. Clone the repository:
   ```sh
   git clone https://github.com/SujoySust/Lottery-Smart-Contract
   ```
2. Install project dependencies:
    ```sh
    cd lottery-smart-contract
    npm install
    ```
### Running Tests
1. Make sure you have Ganache running or another Ethereum development blockchain.
2. Run the Truffle tests:
    ```sh
    truffle test
    ```
### Usage
1. Deploy the smart contract to an Ethereum network of your choice.
2. Interact with the deployed contract using a tool like MyEtherWallet or through a custom UI.
3. Players can enter the lottery by sending the required Ether to the contract's enter function.
4. The owner can pick a winner using the pickWinner function, which transfers the contract's balance to the winner.

### Contributing

Contributions are welcome! If you find any issues or have suggestions for improvements, feel free to open an issue or submit a pull request.

### License
This project is licensed under the MIT License - see the LICENSE file for details.
