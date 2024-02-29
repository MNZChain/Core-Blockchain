
# MainnetZ Blockchain Node

This project aims to provide installation, running, and maintenance capabilities of **MainnetZ validator node** for potential and existing MainnetZ Blockchain backers. The consensus structure of this chain is delegated proof of stake "DPos" and is governed by the symbiosis of MainnetZ's implementation of go-ethereum and our system contracts [https://github.com/MNZChain/system-smart-contracts]. This repository has multiple release candidates inline so we recommend checking for updates for better functions and stability.


## Acknowledgements
MainnetZ blockchain node inherits its core components from heco-chain project by stars-lab which itself is based on geth by the Ethereum foundation.

 - [Go ethereum](https://github.com/ethereum/go-ethereum)
 - [heco-chain](https://github.com/stars-labs/heco-chain)

The revolution started by Bitcoin and later fueled by Ethereum Foundation has launched a wide array of technological advancements and applications.
We acknowledge and actively contribute to decentralization causes and derivatives.


# Consensus
`MainnetZ` adopts `DPoS` consensus mechanism with low transaction cost, low transaction latency, high transaction concurrency, and supports up to 30 validators.

DPoS is a combination of PoA and Pos. To become a validator, you need to submit a proposal first and wait for other active validators to vote on it, after more than half of them pass, you will be eligible to become a validator. Any address can stake to an address that qualifies to become a validator, and after the validator's staking volume ranks in the top 30, it will become an active validator in the next epoch.


All active verifiers are ordered according to predefined rules and take turns to pack out blocks. If a validator fails to pack out a block in time in its own round, the active validators who have not involved  in the past n/2 (n is the number of active validators) blocks will randomly perform the block-out. At least n/2+1 active validators work properly to ensure the proper operation of the blockchain.


The difficulty value of a block is 2 when the block is generated normally and 1 when the block is not generated in a predefined order. when a fork of the block chain occurs, the block chain selects the corresponding fork according to the cumulative maximum difficulty.

## Glossary 
- validator. Responsible for packaging out blocks for on-chain transactions.
- active validator. The current set of validators responsible for packing out blocks, with a maximum of 30.
- epoch. Time interval in blocks, currently 1epoch = 200block on `MainnetZ`. At the end of each epoch, the blockchain interacts with the system contracts to update active validators.

## System contract
[mainnetz-contracts](https://github.com/MNZChain/System-Contracts)

The management of the current validators are all done by the system contracts.
- Proposal  Responsible for managing access to validators and managing validator proposals and votes.
- Validators Responsible for ranking management of validators, staking and unstaking operations, distribution of block rewards, etc..
- Punish Responsible for punishing operations against active validators who are not working properly.

Blockchain call system contracts：
- At the end of each block, the `Validators` contract is called and the fees for all transactions in the block are distributed to active validators.
- The `Punish` contract is called to punish the validator  when the validator is  not  working properly.
- At the end of each epoch, the `Validators` contract is called to update active validators, based on the ranking.

## Staking
For any account, any number of coins can be staked to the validator, and the minimum staking amount for each validator is `32 NETZ`.
If you want to unstake, you need to do the following:
1. Send an unstaking transaction for a validator to the `Validators` contract;
2. Waiting for `86400` blocks before sending a transaction to `Validators` contract to withdraw all staking coins on this validator;

## Punishment
Whenever a validator is found not to pack block as predefined, the `Punish` contract is automatically called at the end of this block and the validator is counted. When the count reaches 48, all income of the validator is punished. When the count reaches 96, the validator is removed from the list of active validators, and the validator is disqualified.

## System Requirements

**Operating System:** Ubuntu >= 20.04 LTS

**RAM:** 8GB minimum, 32GB recommended

**Persistent Storage:** 25GB minimum, 100GB high-speed SSD recommended

**Note regarding use of GPUs -** GPUs are primarily used in POW consensus chains. Being a DPos MainnetZ chain has not only more TPS and fast block production but also doesn't need a GPU altogether for its purpose.



## How to become a validator
To back the MainnetZ blockchain you can become a validator. Full flow to become a validator, you must:
* Install this package **([See Installation](#installation))**
* Download your newly created validator wallet from your server and import it into your metamask or preferred wallet. Fund this account with the appropriate MNZ tokens needed to become a validator. Example command to download the wallet on your local PC. Only works for UNIX-based OSes or on any environment that can run the OpenSSH package:
```bash
  scp -r root@<server_ip>:/root/Core-Blockchain/chaindata/node1/keystore
  scp root@<server_ip>:/root/Core-Blockchain/chaindata/node1/pass.txt
```
* On your server, start the node that you just installed **([See Usage/Example](#usageexamples))**
* Once the node is started and confirmation is seen on your terminal, open the interactive console by attaching tmux session **([See Usage/Example](#usageexamples))**
* Once inside the interactive console, you'll see "IMPORTED TRANSACTION OBJECTS" and "age=<some period like 6d5hr or 5mon 3weeks>". You need to wait until the "unauthorized validator" warning starts to pop up on the console. 
* Once "unauthorized validators" warning shows up, go to https://staking.mainnetz.io/ and click "Become a validator". Fill in all the details in the form, in the "Fee address" field enter the validator wallet address that you imported into your metamask. Proceed further
* Once the last step is done, you'll see a "🔨 mined potential block" message on the interactive console. You'll also see your validator wallet as a validator on the staking page and on explorer. You should also detach from the console after the whole process is done **([See Usage/Example](#usageexamples))**
## Installation

**You must ensure that:** 
* system requirements are met with careful supervision
* the concerned server/local setup must be running 24/7 
* there is sufficient power and cooling arrangement for your machine if running a local setup 
If failed you may end up losing your stake in the blockchain and your staked coins, if any. You'll be jailed at once with no return point by the blockchain if found down/dead. You'll be responsible for chain data corruption on your node, frying up your motherboard, or damaging yourself and your surroundings. 


To install the MainnetZ validator node in ubuntu linux
```bash
  sudo -i
  apt update && apt upgrade
  apt install git tar curl wget
  reboot
```
Skip the above commands if you have already updated the system and installed the necessary tools.

Connect again to your server after reboot
```bash
  sudo -i
  git clone https://github.com/MNZChain/Core-Blockchain.git
  cd core-blockchain
  ./node-setup --validator 1
```
After you run node-setup, follow the on-screen instructions carefully and you'll get confirmation that the node was successfully installed on your system.

**Note regarding your validator account -** While in the setup process, you'll be asked to create a new account that must be used for block mining and receiving gas rewards. You must import this account to your metamask or any preferred wallet. 
 
    
## Usage/Examples

Display help
```bash
./node-setup.sh --help
```
To create/install a validator node. Fresh first-time install
```bash
./node-setup.sh --validator 1
```
To run the validator node
```bash
./node-start.sh --validator
```
To create/install a RPC node. Fresh first-time install
```bash
./node-setup.sh --rpc
```
To run the RPC node
```bash
./node-start.sh --rpc
```
To get into a running node's interactive console/tmux session 
```bash
tmux attach -t node1
```
To exit/detach from an interactive console
```text
Press CTRL & b , release both keys, and press d
```



