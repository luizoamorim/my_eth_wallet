# Project Goals
- Create a local blockchain network with ganache;
- Connect to localhost ganache network with metamask;
- Set up an initial envinroment with truffle;
- Create a ERC20 token with solidity;
- Deploy the token;
- Create a intital app with create react app;
- Connect and manage the local blockchain accounts with web3.js;

## Create a local blockchain network with ganache

[What ganache is?](https://www.trufflesuite.com/docs/ganache/overview)
Ganache is a personal blockchain for rapid Ethereum and Corda distributed application development. You can use Ganache across the entire development cycle; enabling you to develop, deploy, and test your dApps in a safe and deterministic environment. 

Ganache starts at http://127.0.0.1:7545 and creates 10 starting addresses with 100 ether each.
This is enough to build the application.

## Connect to localhost ganache network with metamask

[Metamask](https://metamask.io/) is a wallet for ethereum. 
With this we can create a new account importing the private key from some address of ganache network.
This way it's possible to use this address on our app.

## Set up an initial envinroment with truffle

[Truffle](https://www.trufflesuite.com/) is a tool that allow us to automate the deploy process for smart contracts and tokens on ethereumm network.

To start with it is necessary install the tool with npm.
```
npm install -g truffle
```

Did it we can use this. To initalize the environment use the follow command:
```
truffle init
```
It will create a structure of the project with the initial files and folders.


## Create a ERC20 token with solidity
Solidity is an object-oriented, high-level language for implementing smart contracts. 
Smart contracts are programs which govern the behaviour of accounts within the Ethereum state.

When you start an initial truffle environment, a standard contract is created. It's Migration.sol.
The migration contract keeps track of which migrations were made on the current network.
Then you can see that in the migration folder there is a 1_inital_migration.js file. As new contracts are
created, you can change this file or create another one with the number '2' at the beginning of the name.

Then we'll create a new contract and a new migration file. The migration file is used to deploy our smart contract
or token on the blockchain network.

Trully we'll create a ERC20 token. 

### ERC20
The [ERC-20](https://ethereum.org/en/developers/docs/standards/tokens/erc-20/) introduces a standard for Fungible Tokens, in other words, they have a property that makes each Token be exactly the same (in type and value) of another Token. For example, an ERC-20 Token acts just like the ETH, meaning that 1 Token is and will always be equal to all the other Tokens.

In our example, I will create a token called MuscleToken. I don't know why that name. I just thought and put = D

```
pragma solidity >= 0.5.16;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MuscleToken is ERC20 {
    constructor() ERC20("Muscle", "MCL") {
        _mint(msg.sender, 1000000000000000000000);
    }
}
```

For it we'll use a library called [openzeppelin](https://www.npmjs.com/package/@openzeppelin/contracts) that allow us to implements the ERC20 standard.
Our token will be very simple. Let's just pass a name, a symbol and set a ammount for the address
that is connected to the network through the metamask.

## Deploy the token

## Create a intital app with create react app

This project was bootstrapped with [Create React App](https://github.com/facebook/create-react-app).

You can learn more in the [Create React App documentation](https://facebook.github.io/create-react-app/docs/getting-started).

To learn React, check out the [React documentation](https://reactjs.org/).

