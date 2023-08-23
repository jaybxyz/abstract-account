#!/bin/sh

# Set necessary variables
BINARY=simd
CHAIN_ID=localnet
CHAIN_DIR=$HOME/.simapp
MNEMONIC_1="guard cream sadness conduct invite crumble clock pudding hole grit liar hotel maid produce squeeze return argue turtle know drive eight casino maze host"
MNEMONIC_2="friend excite rough reopen cover wheel spoon convince island path clean monkey play snow number walnut pull lock shoot hurry dream divide concert discover"
MNEMONIC_3="fuel obscure melt april direct second usual hair leave hobby beef bacon solid drum used law mercy worry fat super must ritual bring faculty"
GENESIS_COINS=10000000000000stake,10000000000000uatom

# Stop process if it is already running 
if pgrep -x "$BINARY" >/dev/null; then
    echo "Terminating $BINARY..."
    killall $BINARY
fi

# Remove previous data
rm -rf $CHAIN_DIR

# Initialize chain
$BINARY init test --chain-id $CHAIN_ID

# Add keys
echo $MNEMONIC_1 | $BINARY keys add validator --recover --keyring-backend=test 
echo $MNEMONIC_2 | $BINARY keys add user1 --recover --keyring-backend=test 
echo $MNEMONIC_3 | $BINARY keys add user2 --recover --keyring-backend=test 

# Add genesis accounts
$BINARY genesis add-genesis-account $($BINARY keys show validator --keyring-backend test -a) $GENESIS_COINS
$BINARY genesis add-genesis-account $($BINARY keys show user1 --keyring-backend test -a) $GENESIS_COINS
$BINARY genesis add-genesis-account $($BINARY keys show user2 --keyring-backend test -a) $GENESIS_COINS

# Get pre-prepared priv_validator_key.json file
curl https://gist.githubusercontent.com/jaybxyz/7ede48515df4fcff8497a41175e952a9/raw/e59db08c713cc69d08f7300fa6de4ad8d74a5194/simapp-abstract-account-priv_validator_key.json -o $HOME/.simapp/config/priv_validator_key.json

# Get pre-prepared genesis.json file
curl https://gist.githubusercontent.com/jaybxyz/df316413a5292d4580af550177fa92b2/raw/d3c190f576ee044ed4aa68504896b6b1b039e97c/simapp-abstract-account-genesis.json -o $HOME/.simapp/config/genesis.json

# Start
$BINARY start --grpc.address="0.0.0.0:9090"