To run this code:<br>
1- clone repository and open a shell inside of it<br>
2- ```npm install hardhat```<br>
3-enter your informatin in hardhat.config.js<br>

To test:<br>
```npx hardhat test```<br>

```
  SafeFactory
SafeFactory deployed
calling deploySafe function
Transaction receipt: ContractTransactionReceipt {
  provider: HardhatEthersProvider {
    _hardhatProvider: LazyInitializationProviderAdapter {
      _providerFactory: [AsyncFunction (anonymous)],
      _emitter: [EventEmitter],
      _initializingPromise: [Promise],
      provider: [BackwardsCompatibilityProviderAdapter]
    },
    _networkName: 'hardhat'
  },
  to: '0x5FbDB2315678afecb367f032d93F642f64180aa3',
  from: '0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266',
  contractAddress: null,
  hash: '0x6833400c03d5854581ae772056375612fed0c0e45d1197dcf4043d38319f4366',
  index: 0,
  blockHash: '0xf11cbda63c00c99c441292830b679e86f7767156c9bec8debb7ca19707cf1fec',
  blockNumber: 2,
  logsBloom: '0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000040000000000000000500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000200000000000000000000000000000800000000010000000000040000000000000000000000000040000000200000000000000000000000002000000000000000000000000000000000000000200000000040000000000000000000000000000000000000',
  gasUsed: 211491n,
  cumulativeGasUsed: 211491n,
  gasPrice: 773052862n,
  type: 2,
  status: 1,
  root: undefined
}
SafeDeployed event: safeAddress = 0xeEBe00Ac0756308ac4AaBfD76c05c4F3088B8883
    √ should deploy the non-upgradeable version with create1
calling deploySafeWithCreate2 function
Transaction receipt: ContractTransactionReceipt {
  provider: HardhatEthersProvider {
    _hardhatProvider: LazyInitializationProviderAdapter {
      _providerFactory: [AsyncFunction (anonymous)],
      _emitter: [EventEmitter],
      _initializingPromise: [Promise],
      provider: [BackwardsCompatibilityProviderAdapter]
    },
    _networkName: 'hardhat'
  },
  to: '0x5FbDB2315678afecb367f032d93F642f64180aa3',
  from: '0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266',
  contractAddress: null,
  hash: '0xbfd223cc71c0eec61bed7d53c33e960a8916f837de90715c3f4bffa3752f9691',
  index: 0,
  blockHash: '0x3fa7cb40be2ab364c81b86505b7f634eeadc4f23597d7fc4a30e858f88b73fdc',
  blockNumber: 3,
  logsBloom: '0x00000000000000000000000000000000000200000000000000000000000000000000000000000000000040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000040000000000000000500000000002000000000000000000000000000000000000000000000000000000000000000000000000000000000000200000000000000000000000000000800000000000000000000000000000000000000000000000040000000200000000000000000000000002000000000000000000000000000000000000000200000000000000000000000000000000000000000000000',
  gasUsed: 214757n,
  cumulativeGasUsed: 214757n,
  gasPrice: 677783703n,
  type: 2,
  status: 1,
  root: undefined
}
SafeDeployed event: safeAddress = 0xB7E957Ae1f0827a2b3e82FDE2185C37d88476b83
    √ should deploy the non-upgradeable version with create2
calling deploySafeUpgradeable function
Transaction receipt: ContractTransactionReceipt {
  provider: HardhatEthersProvider {
    _hardhatProvider: LazyInitializationProviderAdapter {
      _providerFactory: [AsyncFunction (anonymous)],
      _emitter: [EventEmitter],
      _initializingPromise: [Promise],
      provider: [BackwardsCompatibilityProviderAdapter]
    },
    _networkName: 'hardhat'
  },
  to: '0x5FbDB2315678afecb367f032d93F642f64180aa3',
  from: '0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266',
  contractAddress: null,
  hash: '0xd3edd5b23e82060c5a5bf7893c2bbd49e383d852a537cbf87e65bc3ac4fe8263',
  index: 0,
  blockHash: '0x5dc56fc9327229c48c6ab969db79d6eb471961e012e2b7b472162e1670ba6b3f',
  blockNumber: 4,
  logsBloom: '0x00000000000000000000000000000000000000400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000400000000000000000000040000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000200000000000000000000000000000000000000800000000000000000000000000000000004000040000000200000000000000000000000002000000000000000000020000000000000000000000000000000000000000000000000000000040000000000',
  gasUsed: 112318n,
  cumulativeGasUsed: 112318n,
  gasPrice: 594273731n,
  type: 2,
  status: 1,
  root: undefined
}
SafeUpgradeableDeployed event: proxyAddress = 0x603E1BD79259EbcbAaeD0c83eeC09cA0B89a5bcC
    √ should deploy the upgradeable version with create1
calling deploySafeUpgradeableWithCreate2 function
Transaction receipt: ContractTransactionReceipt {
  provider: HardhatEthersProvider {
    _hardhatProvider: LazyInitializationProviderAdapter {
      _providerFactory: [AsyncFunction (anonymous)],
      _emitter: [EventEmitter],
      _initializingPromise: [Promise],
      provider: [BackwardsCompatibilityProviderAdapter]
    },
    _networkName: 'hardhat'
  },
  to: '0x5FbDB2315678afecb367f032d93F642f64180aa3',
  from: '0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266',
  contractAddress: null,
  hash: '0xfe26dbcbf43606c690b14c385d9e478d73c7d6bb62f928a004bd8eef41b201b6',
  index: 0,
  blockHash: '0xbeda5309bf70a7acd81f8bf0fcae69f6e0144e4e0c8401aecc50b558518e1efc',
  blockNumber: 5,
  logsBloom: '0x00000000000000000000000000000000000000400000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000040000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000200000000040000000000000000000000000000800000000000000000000000000000000000000040000000200000000000000000000000002000000000000000000020000000000000000000000040000000000000000000000000000000000000000000',
  gasUsed: 112860n,
  cumulativeGasUsed: 112860n,
  gasPrice: 520545746n,
  type: 2,
  status: 1,
  root: undefined
}
SafeUpgradeableDeployed event: proxyAddress = 0x620C0f7f1F585C0f702E77161D7f58a6259e19d6
    √ should deploy the upgradeable version with create2


  4 passing (107ms)

······························································································································
|  Solidity and Network Configuration                                                                                        │
·········································|················|················|·················|································
|  Solidity: 0.8.24                      ·  Optim: true   ·  Runs: 1000    ·  viaIR: false   ·     Block: 30,000,000 gas     │
·········································|················|················|·················|································
|  Methods                                                                                                                   │
·········································|················|················|·················|················|···············
|  Contracts / Methods                   ·  Min           ·  Max           ·  Avg            ·  # calls       ·  usd (avg)   │
·········································|················|················|·················|················|···············
|  MyOwnSafeFactory                      ·                                                                                   │
·········································|················|················|·················|················|···············
|      deploySafe                        ·             -  ·             -  ·        211,491  ·             2  ·           -  │
·········································|················|················|·················|················|···············
|      deploySafeUpgradeable             ·             -  ·             -  ·        112,318  ·             2  ·           -  │
·········································|················|················|·················|················|···············
|      deploySafeUpgradeableWithCreate2  ·             -  ·             -  ·        112,860  ·             2  ·           -  │
·········································|················|················|·················|················|···············
|      deploySafeWithCreate2             ·             -  ·             -  ·        214,757  ·             2  ·           -  │
·········································|················|················|·················|················|···············
|  Deployments                                            ·                                  ·  % of limit    ·              │
·········································|················|················|·················|················|···············
|  MyOwnSafeFactory                      ·             -  ·             -  ·      1,018,678  ·         3.4 %  ·           -  │
·········································|················|················|·················|················|···············
|  Key                                                                                                                       │
······························································································································
|  ◯  Execution gas for this method does not include intrinsic gas overhead                                                  │
······························································································································
|  △  Cost was non-zero but below the precision setting for the currency display (see options)                               │
······························································································································
|  Toolchain:  hardhat                                                                                                       │
······························································································································

```
<br>
Coverage
<br>
```
-----------------------------------|----------|----------|----------|----------|----------------|
File                               |  % Stmts | % Branch |  % Funcs |  % Lines |Uncovered Lines |
-----------------------------------|----------|----------|----------|----------|----------------|
 contracts\                        |    78.95 |     7.14 |    53.85 |    71.43 |                |
  MyOwnSafeContract.sol            |        0 |        0 |       25 |       20 |    13,14,22,26 |
  MyOwnSafeFactory.sol             |      100 |      100 |      100 |      100 |                |
  MyOwnSafeUpgradeableContract.sol |    33.33 |     12.5 |       25 |    42.86 |    14,15,25,29 |
-----------------------------------|----------|----------|----------|----------|----------------|
All files                          |    78.95 |     7.14 |    53.85 |    71.43 |                |
-----------------------------------|----------|----------|----------|----------|----------------|

```
