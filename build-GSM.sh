#!/bin/sh

# These components are built
reposes="
libosmo-netif
libosmocore
libosmo-abis
osmo-bts
osmo-trx
osmo-sigtran
libosmo-sccp
osmo-mgw
osmo-bsc
osmo-pcu
osmo-hlr
libsmpp34
osmo-msc
osmo-ggsn
osmo-sgsn
"

for r in $reposes; do
    ./build.sh $r
done