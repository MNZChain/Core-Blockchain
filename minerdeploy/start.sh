#! /bin/bash
sh -c 'cd /app; ./geth --datadir mainnetz --networkid 77612 --bootnodes "enr:-KO4QN6ZWmGyrhhm8gvf-2kQfkxRNTVgAPhxvfdPX4tA3CIIVRfBcyT4_3d2ukCeTKbByUotav-LUzbqyWT-pBxonVeGAYWW5uTkg2V0aMfGhP-FS6eAgmlkgnY0gmlwhIm4QKuJc2VjcDI1NmsxoQNHZ5kjor-ok3f0zQ765YgQkSne9H4RaRpsdKNwUW-hCYRzbmFwwIN0Y3CCf5yDdWRwgn-c" --mine --syncmode full --unlock 0 --password /app/.accountpassword'
