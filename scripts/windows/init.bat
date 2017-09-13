rd %datadir% /S /Q
mkdir %datadir%
geth --datadir %datadir% init ../../config/genesis.json
xcopy "../../config/keystore" "%datadir%/keystore" /y /s
