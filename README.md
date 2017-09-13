# ethereum-private-network
Instructions on how to setup an ethereum private test network for development in Windows platform.
The original is for Mac OS X. You can get it [here](https://github.com/chafey/ethereum-private-network)

Install Geth
------------

[Geth](https://github.com/ethereum/go-ethereum/wiki/geth) is the command line
interface for running a full ethereum node implemented in Go.

Account Information
-----------------------------
1.  address : 0x5ed005cc68a69B979CB2797BA8CA817722B6e6De
    privateKey : 17d53d74feb5eebb36307a436c1c3bfa7698f68e60d3f627c612008d447a8f23
    password : Password123
2.  address : 0xE994bFA2eAdeB1412eB1DDCb967E136b118cA26a
    privateKey : 68951804259a1739d0933f2e1bf7e1f59c84875775cfbc3f1f8d211d4c7f6dd6
    password : Password123
3.  address : 0x4C10289f43d500ba52fDbBafd7d98A171912aAa4
    privateKey : cf8555588e0151bc31adb94c59c30cab8a5f29453270a6f2e400edf57d757a50
    password : Password123
4.  address : 0x75e7eD7374c494E5991D3Fdef66074c2365C82eF
    privateKey : 0d978b068e64f2e2c65111267039ab198d18ebc8f92bc998738dca3a24f53422
    password : Password123
5.  address : 0xb59A1332041DE48E03A01338B9961d48Df2a27A4
    privateKey : daca3c847e884eb37f8ae1e04a293b64195362551a298ae6b3a6be731e27cba1
    password : Password123

Initialize local test network
-----------------------------

You need to set environment variable before run any scripts !!?
You can set it by run command 
  set datadir = "Your privatenet chain data"

The first thing you need to do is initialize your ethereum test network:

> scripts/init.bat

This script will clear/reset your ethereum blockchain and create the following
accounts:

Start ethereum mining node
--------------------------

The ethereum network needs a mining node to process transactions:

> scripts/mine.bat

The first time you run geth on your machine, it will generate a DAG.  This can
take several minutes depending upon the speed of your CPU.  Once it finishes
generating the DAG, it will start mining and generating messages like this:

```
I0124 14:41:07.325501 miner/unconfirmed.go:83] 🔨  mined potential block #1 [f60eb249…], waiting for 5 blocks to confirm
I0124 14:41:07.325835 miner/worker.go:516] commit new work on block 2 with 0 txs & 0 uncles. Took 225.475µs
```

The mining node deposits ethereum into the following account:

0x5DFE021F45f00Ae83B0aA963bE44A1310a782fCC

Attach to your mining node
--------------------------

You can interact with the ethereum network by attaching to your mining node:

> bin/attach

This will present a javascript console where you can run various commands

Send ether from one account to another
--------------------------------------

Form the console attached to your mining node, you can send ether from one
 account to another.  First we check the balances of the from and to accounts:

> var from = web3.eth.accounts[1]

> personal.unlockAccount(from, 'iloveethereum')

> web3.eth.getBalance(from)

10000000000000000000

> var to = web3.eth.accounts[2]

> web3.eth.getBalance(to)

20000000000000000000

Now we send ether:

> eth.sendTransaction({from: from, to: to, value: 1})

"0xdc6a6858f57c100398dabb5868549a6a113508b40bcc43b5b5aad639821c3fad"

If you check the mining node console, you will see this transaction logged:

```
I0124 09:35:24.849818 internal/ethapi/api.go:1047]
Tx(0xdc6a6858f57c100398dabb5868549a6a113508b40bcc43b5b5aad639821c3fad)
to: 0x22fb800aaeab6af13e8fd76623b6acab3ee15b62
```

Now you can check the balances of the from and to account to verify that
ether was moved:

> web3.eth.getBalance(from)

9999579999999999999

NOTE: The reason more than 1 is gone from the ether balance is because it costs
ether to execute the send ether transaction.  This transaction fee is given to
the miner.

> web3.eth.getBalance(to)

20000000000000000001

Deploy the greeter contract and call the greet method
-----------------------------------------------------

From the attached console, you can deploy the
[greeter smart contract](https://www.ethereum.org/greeter) and
use it:

> loadScript('deploy.js');

```
Contract mined! address: 0x1b9dfd2ea79f59491b7881c508010af5410cd096 transactionHash: 0xe92dfdbea562e59661a483f21b8d2fedebebe4eb0b9cee00bfc9fb97ffa329e6
null [object Object]
Contract mined! address: 0xe9f5d76475b180a709025dde31091b9793742119 transactionHash: 0x1ca2b4240d5957ea68ff9dc5aeee08050b8d533e1636586e47ad9222b945b1f1
```

> greeter.greet();

"hello private test network"

NOTE: The contract in deploy.js is the default contract displayed in the
[online solidity compiler](https://ethereum.github.io/browser-solidity)
