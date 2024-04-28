To run this code:<br>
1- clone repository and open a shell inside of it<br>
2- ```npm install hardhat```<br>
3-enter your informatin in hardhat.config.js<br>

To test:<br>
```npx hardhat test```<br>

To deploy:<br>
1-```npx hardhat run scripts/deploySCV1.js --network zircuit ``` <br>
2-modify the file with the address os SafeContract and <br>
```npx hardhat run scripts/deployProxy.js --network zircuit```<br>
3-```npx hardhat run scripts/deploySCV2.js --network zircuit```<br>

To upgrade:<br>
enter your private key, address of the proxy and of SafeContractV2 <br>
1-```npx hardhat run scripts/shouldUpgrade.js --network zircuit```<br>

To see if fee is still there:<br>
enter your private key and address of the proxy <br>
1-```npx hardhat run scripts/shouldRevert.js --network zircuit```<br>

Expected result for test and gas report <br>

```
  SafeProxy
    √ Should set the deployer as the owner and implementation to safeContractV1
    √ Should revert addr1 not the owner
    √ Should change the current implementation from safeContractV1 to safeContractV2

  SafeContract
    √ Should set the right owner
    √ Should deposit, withdraw tokens and take fee (46ms)
    √ should revert takeFee call from user
    √ should revert takeFee call because no fee
    √ should revert withdraw call because no token left

  SafeContractV2
    √ Should set the right owner
    √ Should deposit, withdraw tokens and no more fee


  10 passing (464ms)

·············································································································
|  Solidity and Network Configuration                                                                       │
························|················|················|·················|································
|  Solidity: 0.8.24     ·  Optim: true   ·  Runs: 1000    ·  viaIR: false   ·     Block: 30,000,000 gas     │
························|················|················|·················|································
|  Methods                                                                                                  │
························|················|················|·················|················|···············
|  Contracts / Methods  ·  Min           ·  Max           ·  Avg            ·  # calls       ·  usd (avg)   │
························|················|················|·················|················|···············
|  SafeContract         ·                                                                                   │
························|················|················|·················|················|···············
|      deposit          ·             -  ·             -  ·         73,317  ·             2  ·           -  │
························|················|················|·················|················|···············
|      takeFee          ·             -  ·             -  ·         36,101  ·             2  ·           -  │
························|················|················|·················|················|···············
|      withdraw         ·             -  ·             -  ·         77,957  ·             2  ·           -  │
························|················|················|·················|················|···············
|  SafeContractV2       ·                                                                                   │
························|················|················|·················|················|···············
|      deposit          ·             -  ·             -  ·         73,317  ·             2  ·           -  │
························|················|················|·················|················|···············
|      withdraw         ·             -  ·             -  ·         52,291  ·             2  ·           -  │
························|················|················|·················|················|···············
|  SafeProxy            ·                                                                                   │
························|················|················|·················|················|···············
|      upgradeTo        ·             -  ·             -  ·         31,196  ·             1  ·           -  │
························|················|················|·················|················|···············
|  Token                ·                                                                                   │
························|················|················|·················|················|···············
|      approve          ·             -  ·             -  ·         46,346  ·             2  ·           -  │
························|················|················|·················|················|···············
|      transfer         ·             -  ·             -  ·         51,573  ·             2  ·           -  │
························|················|················|·················|················|···············
|  Deployments                           ·                                  ·  % of limit    ·              │
························|················|················|·················|················|···············
|  SafeContract         ·             -  ·             -  ·        490,867  ·         1.6 %  ·           -  │
························|················|················|·················|················|···············
|  SafeContractV2       ·             -  ·             -  ·        370,277  ·         1.2 %  ·           -  │
························|················|················|·················|················|···············
|  SafeProxy            ·             -  ·             -  ·        282,121  ·         0.9 %  ·           -  │
························|················|················|·················|················|···············
|  Token                ·             -  ·             -  ·      1,268,235  ·         4.2 %  ·           -  │
························|················|················|·················|················|···············
|  Key                                                                                                      │
·············································································································
|  ◯  Execution gas for this method does not include intrinsic gas overhead                                 │
·············································································································
|  △  Cost was non-zero but below the precision setting for the currency display (see options)              │
·············································································································
|  Toolchain:  hardhat                                                                                      │
·············································································································
```
