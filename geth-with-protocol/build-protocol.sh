mkdir /psrc && cd /psrc

git clone -b confluence https://github.com/livepeer/protocol.git
srcDir=/psrc
cd $srcDir/protocol

git checkout e8b6243c48d9db33852310d2aefedd5b1c77b8b6
nohup bash -c "/start.sh &" &&
sleep 4

OPWD=$PWD
cd $srcDir/protocol
echo "yarn config set unsafe-perm true"
yarn config set unsafe-perm true
echo "npm config set unsafe-perm=true"
npm config set unsafe-perm=true
echo "yarn install"
yarn install
echo "npx hardhat typechain"
npx hardhat typechain
migrateCmd="yarn deploy --network gethDev"
echo "Running $migrateCmd"
eval $migrateCmd
unpauseCmd="npx hardhat unpause --network gethDev"
echo "Running $unpauseCmd"
eval $unpauseCmd
controllerAddress=$(npx hardhat print-contract-address --contract Controller --network gethDev)
echo "Controller address: $controllerAddress"
echo $controllerAddress > $gethRoot/controllerAddress
migrateArbitrumLPTMockCmd="npx hardhat deploy --tags ARBITRUM_LPT_DUMMIES --network gethDev"
echo "Running $migrateArbitrumLPTMockCmd"
eval $migrateArbitrumLPTMockCmd
cd $OPWD
sleep 3
# now we need to wait till 100 block mined (so current protocol round will be 2)
while true
do
    blockNumber=$(geth attach --exec 'eth.blockNumber')
    echo "Current block is $blockNumber"

    if [ $blockNumber -gt 101 ]
    then
        echo "Good to go"
        break
    else
        echo "Need to wait till second round - we can't initialize transcoders in first one"
        sleep 5
    fi
done
# gracefully shutdown geth
pkill -9 geth
# let geth to write his data files to disk
sleep 1
