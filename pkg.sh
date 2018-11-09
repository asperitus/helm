#!/usr/bin/env bash

CHARTS=(
btcpayd
flink
foregate
kafka-manager
lightningd
matrix
nifi
nifi-registry
)

for c in ${CHARTS[@]}; do
    helm package $c
done

##