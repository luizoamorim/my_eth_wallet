# Project Goals
- Create a local blockchain network with ganache;
- Connect to localhost ganache network with metamask;
- Create a intital app with create react app;
- Set up an initial envinroment with truffle;
- Create a ERC20 token with solidity;
- Deploy the token;
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

## Create a intital app with create react app

This project was bootstrapped with [Create React App](https://github.com/facebook/create-react-app).

You can learn more in the [Create React App documentation](https://facebook.github.io/create-react-app/docs/getting-started).

To learn React, check out the [React documentation](https://reactjs.org/).


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
To deploy our token we need to create a new migration file, like this:
```
const MuscleToken = artifacts.require("MuscleToken");

module.exports = async function (deployer) {
  await deployer.deploy(MuscleToken);  
};
```
Now we can compile and deploy the ERC20 token. For this execute the follow commands:
```
truffle compile
truffle migrate
```

Did it you can see the contracts on ganache network.

## Connect and manage the local blockchain accounts with web3.js
We will do this using the ReactJs.

When our React component be initialized we'll execute two functions:

### loadWeb3() 

```
async loadWeb3() {
    if (window.ethereum) {
      window.web3 = new Web3(window.ethereum)
      await window.ethereum.enable()      
    }
    else if (window.web3) {
      window.web3 = new Web3(window.web3.currentProvider)      
    }
    else {
      window.alert('Non-Ethereum browser detected. You should consider trying MetaMask!')
    }
}
```

This function is responsible for establishing the connection and authorizing us to interact with the blockchain.
To work with our Token, we will need a new instance of Web3. When creating this instance, we need to specify the provider we want to use. Since we are using MetaMask as a proxy, we use the window.ethereum provider injected by the MetaMask extension.

Ref: https://livecodestream.dev/post/interacting-with-smart-contracts-from-web-apps/

## loadBlockchainData()

```
async loadBlockchainData() {
    const web3 = window.web3
    const accounts = await web3.eth.getAccounts()
    this.setState({ account: accounts[0] })
    console.log(accounts)
    const muscleTokenAddress = "0xFeee1B17c0F4E0394270141aDfEaa7b8187d3360" // Replace MCL Address Here
    const muscleToken = new web3.eth.Contract(MuscleToken.abi, muscleTokenAddress)
    this.setState({ muscleToken: muscleToken })
    const balance = await muscleToken.methods.balanceOf(this.state.account).call()
    this.setState({ balance: web3.utils.fromWei(balance.toString(), 'Ether') })
    const transactions = await muscleToken.getPastEvents('Transfer', { fromBlock: 0, toBlock: 'latest', filter: { from: this.state.account } })
    this.setState({ transactions: transactions })
    console.log(transactions)
}
```

Here we have the web3 instance. With it it is possible to get our account.
Next, we need to define the address of the token to obtain its reference.
That done, we can get the balance and transactions from our account.

We have another function which allow transferences between accounts.

```
transfer(recipient, amount) {
    this.state.muscleToken.methods.transfer(recipient, amount).send({ from: this.state.account })
}
```
We pass the address of the recipient and the ammount in parameters.

# Result

The final result of our application:

![image](https://user-images.githubusercontent.com/73957838/114333162-0af3b500-9b1e-11eb-8c02-88d64dcf3d9a.png)

# How to use
Run:
```
npm run start
```
At this moment we'll be connected with the account that we imported on metamask.
Choose another account on ganache and import it too on metamask wallet.
So you can put this account on recipient address and put a value to transfer to it.
Click on the button and the transfer will be triggered on metamask.

# References
- I followed the steps shown in this video:
https://www.youtube.com/watch?v=wSTbBIK8qrY&t=1091s