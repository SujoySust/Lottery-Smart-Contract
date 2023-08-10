const Lottery = artifacts.require("Lottery");

contract("Lottery", (accounts) => {
  let lotteryInstance;
  const owner = accounts[0];
  const user1 = accounts[1];
  const user2 = accounts[2];

  beforeEach(async () => {
    lotteryInstance = await Lottery.new({ from: owner });
  });

  it("should have the correct initial owner", async () => {
    const owner = await lotteryInstance.owner();
    assert.equal(owner, owner, "Owner should be the deployer");
  });

  it("should have the initial lotteryId as 1", async () => {
    const lotteryId = await lotteryInstance.lotteryId();
    assert.equal(lotteryId, 1, "Initial lotteryId should be 1");
  });

  it("should allow a player to enter the lottery", async () => {
    await lotteryInstance.enter({ from: user1, value: web3.utils.toWei("0.02", "ether") });
    const players = await lotteryInstance.getPlayers();
    assert.equal(players.length, 1, "Number of players should be 1");
    assert.equal(players[0], user1, "Player's address should match");
  });

  it("should correctly update the balance after player enters", async () => {
    const initialBalance = await web3.eth.getBalance(owner);
    await lotteryInstance.enter({ from: user1, value: web3.utils.toWei("0.02", "ether") });
    const newBalance = await web3.eth.getBalance(owner);
    assert.equal(newBalance - initialBalance, web3.utils.toWei("0.02", "ether"), "Balance should increase after player enters");
  });

  it("should reset players array after picking a winner", async () => {
    await lotteryInstance.enter({ from: user1, value: web3.utils.toWei("0.02", "ether") });
    await lotteryInstance.pickWinner();
    const players = await lotteryInstance.getPlayers();
    assert.equal(players.length, 0, "Players array should be reset after picking winner");
  });

  it("should retrieve the winner's address for a specific lottery", async () => {
    await lotteryInstance.enter({ from: user1, value: web3.utils.toWei("0.02", "ether") });
    await lotteryInstance.pickWinner();
    const winner = await lotteryInstance.getWinnerByLottery(1);
    assert.equal(winner, user1, "Winner's address should match");
  });
});
