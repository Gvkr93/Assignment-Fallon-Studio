// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

/**
 * @title Simple Token
 * @author Gaurav Kumar
 * @notice A token contract that allows owner to mint tokens and allows users to transfer tokens between each other
 */
contract SimpleToken {
    mapping(address => uint256) private s_balances; //maps people's address to their balances.
    uint256 private totalSupply; //Total supply of tokens

    address public owner; //the owner of contract (account that deployed it).

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Mint(address indexed to, uint256 value);

    /**
     * @dev Set contract deployer as initial owner.
     */
    constructor() {
        owner = msg.sender;
    }

    /**
     * @dev Modifier to restrict function access to owner only.
     */
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this");
        _;
    }

    function name() public pure returns (string memory) {
        return "Simple Token";
    }

    function symbol() public pure returns (string memory) {
        return "STK";
    }

    /**
     * @dev Returns the total supply of tokens in circulation
     */
    function getTotalSupply() public view returns (uint256) {
        return totalSupply;
    }

    /**
     * @dev for knowing its 18 zeros in one ether
     */
    function decimals() public pure returns (uint8) {
        return 18;
    }

    /**
     * @dev Remaining balance of the particular account
     */
    function balanceOf(address account) public view returns (uint256) {
        return s_balances[account];
    }

    /**
     * @dev Mint new tokens and assign them to a specified address.
     * Can only be called by the owner.
     */
    function mint(address _to, uint256 _amount) public onlyOwner {
        require(_to != address(0), "Cannot mint to zero address");

        totalSupply += _amount;
        s_balances[_to] += _amount;

        emit Mint(_to, _amount);
        emit Transfer(address(0), _to, _amount);
    }

    /**
     * @dev Transfer tokens from the sender to another address.
     */
    function transfer(address _to, uint256 _amount) public returns (bool) {
        require(s_balances[msg.sender] >= _amount, "Not enough balance");

        s_balances[msg.sender] -= _amount; // Deducted from sender
        s_balances[_to] += _amount; //Amt added to receiver

        emit Transfer(msg.sender, _to, _amount);
        return true;
    }
}
