// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleSavings {
    mapping(address => uint256) private balances;

    // Deposit ETH to your account
    function deposit() external payable {
        require(msg.value > 0, "Must deposit some ETH");
        balances[msg.sender] += msg.value;
    }

    // Check your balance
    function getBalance() external view returns (uint256) {
        return balances[msg.sender];
    }

    // Withdraw your deposited ETH
    function withdraw(uint256 amount) external {
        require(amount > 0, "Withdraw amount must be greater than zero");
        require(balances[msg.sender] >= amount, "Insufficient balance");

        balances[msg.sender] -= amount;
        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "Withdraw failed");
    }

    // Get total balance held by contract
    function totalBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
