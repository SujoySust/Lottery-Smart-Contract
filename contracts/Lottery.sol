// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

/**
 * @title Lottery
 * @dev A simple decentralized lottery smart contract.
 */
contract Lottery {
    address payable public  owner;                     // Address of the contract owner
    address payable[] public players;          // Array of addresses who entered the lottery
    uint256 public lotteryId;                 // Current lottery ID
    mapping (uint256 => address payable) public lotteryHistory; // Mapping of lottery ID to winner's address

    /**
     * @dev Constructor initializes the contract with the contract owner and sets the initial lottery ID.
     */
    constructor() {
        owner = payable(msg.sender);
        lotteryId = 1;
    }

    /**
     * @dev Get the balance of the contract in ether.
     * @return The balance of the contract.
     */
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    /**
     * @dev Get the list of players who entered the current lottery.
     * @return An array of addresses representing the players.
     */
    function getPlayers() public view returns (address payable[] memory) {
        return players;
    }

    /**
     * @dev Enter the lottery by sending a minimum value of 0.01 ether.
     */
    function enter() public payable {
        require(msg.value > 0.01 ether, "Minimum entry fee: 0.01 ether");
        players.push(payable(msg.sender));
        owner.transfer(msg.value);
    }

    /**
     * @dev Generate a pseudo-random number based on the owner's address and current timestamp.
     * @return A pseudo-random number.
     */
    function getRandomNumber() public view returns (uint256) {
        return uint256(keccak256(abi.encodePacked(owner, block.timestamp)));
    }

    /**
     * @dev Pick a winner from the list of players and transfer the contract's balance to them.
     * Only the contract owner can call this function.
     */
    function pickWinner() public onlyOwner {
        uint256 index = getRandomNumber() % players.length;
        players[index].transfer(address(this).balance);
        lotteryHistory[lotteryId] = players[index];
        lotteryId++;
        players = new address payable[](0);
    }

    /**
     * @dev Get the winner's address for a specific lottery ID.
     * @param lottery The lottery ID to query.
     * @return The winner's address for the given lottery.
     */
    function getWinnerByLottery(uint256 lottery) public view returns (address payable) {
        return lotteryHistory[lottery];
    }

    /**
     * @dev Modifier to ensure that only the contract owner can call certain functions.
     */
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can call this");
        _;
    }
}
