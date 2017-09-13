rd %datadir% /S /Q
mkdir %datadir%
geth --datadir %datadir% init ../../config/genesis.json