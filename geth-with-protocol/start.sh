geth -networkid 54321 -http -ws \
      -http.addr "0.0.0.0" -ws.addr "0.0.0.0" \
      -http.corsdomain "*" -ws.origins "*" \
      -http.vhosts="*" \
      -http.api 'personal,eth,web3,net,txpool,miner,debug' \
      -ws.api 'personal,eth,web3,net,txpool,miner,debug' \
      --unlock '0161e041aad467a890839d5b08b138c1e6373072,87da6a8c6e9eff15d703fc2773e32f6af8dbe301,b97de4b8c857e4f6bc354f226dc3249aaee49209,c5065c9eeebe6df2c2284d046bfc906501846c51' \
      --password $gethRoot/password.txt \
      --nodiscover --maxpeers 0 \
      --miner.gaslimit 0x8000000 \
      --cache=512 \
      -mine -verbosity 2 \
      --allow-insecure-unlock -gcmode "archive" -syncmode "full" \
