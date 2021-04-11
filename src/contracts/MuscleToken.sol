pragma solidity >= 0.5.16;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MuscleToken is ERC20 {
    constructor() ERC20("Muscle", "MCL") {
        _mint(msg.sender, 1000000000000000000000);
    }
}