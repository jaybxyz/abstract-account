# How to run a local network

## 1. Installation

```bash
git clone https://github.com/jaybxyz/simapp.git
cd simapp
make install
```


## 2. Run the following commands

```bash
BINARY=simd

MNEMONIC_1="guard cream sadness conduct invite crumble clock pudding hole grit liar hotel maid produce squeeze return argue turtle know drive eight casino maze host"
MNEMONIC_2="friend excite rough reopen cover wheel spoon convince island path clean monkey play snow number walnut pull lock shoot hurry dream divide concert discover"
MNEMONIC_3="fuel obscure melt april direct second usual hair leave hobby beef bacon solid drum used law mercy worry fat super must ritual bring faculty"
GENESIS_COINS=10000000000000stake,10000000000000uatom

# Initialize chain
$BINARY init test

# Add keys
echo $MNEMONIC_1 | $BINARY keys add validator --recover --keyring-backend=test 
echo $MNEMONIC_2 | $BINARY keys add user1 --recover --keyring-backend=test 
echo $MNEMONIC_3 | $BINARY keys add user2 --recover --keyring-backend=test 

# Add genesis accounts
$BINARY genesis add-genesis-account $($BINARY keys show validator --keyring-backend test -a) $GENESIS_COINS
$BINARY genesis add-genesis-account $($BINARY keys show user1 --keyring-backend test -a) $GENESIS_COINS
$BINARY genesis add-genesis-account $($BINARY keys show user2 --keyring-backend test -a) $GENESIS_COINS
```

## 3. Copy your public key 

Copy your validator's public key from the `$HOME/.simapp/config/priv_validator_key.json` file.

```bash
{
  "address": "...",
  "pub_key": {
    "type": "tendermint/PubKeyEd25519",
    "value": "..."
  },
  "priv_key": {
    "type": "tendermint/PrivKeyEd25519",
    "value": "..."
  }
}
```

## 4. Paste the public key 

Paste the public key to the `$HOME/.simapp/config/genesis.json` file using whichever editor you use.

```result
{
  "app_state": {
    "poa": {
      "validators": [
        {
          "pub_key": {
            "ed25519": "..."
          },
          "power": 1
        }
      ]
    }
  }
}
```

## 5. Start

```bash
simd start
```