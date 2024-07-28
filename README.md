
## Redmilio Heroes

**Redmilio Heroes are a collection of Honorary NFTs celebrating the heroes of Redmilio on Sei.**

### Overview
-   Deployed on Sei "pacific-1" mainnet 
-   All assets and metadata hosted on [Arweave](https://arweave.org/), a storage-oriented decentralized network
-   Based on [ERC721A](https://chiru-labs.github.io/ERC721A/#/), a gas-optimized ERC721 implementation by Chiru Labs



### Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

#### Documentation

https://book.getfoundry.sh/

#### Usage

##### Build

```shell
$ forge build
```

##### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key> --legacy
```

##### Cast

```shell
$ cast <subcommand> --legacy
```

##### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```