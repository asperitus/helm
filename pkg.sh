#!/usr/bin/env bash

helm dependency update lightningd
helm dependency update nifi
helm dependency update wordpress

CHARTS=(
btcpayd
flink
foregate
kafka-manager
lightningd
matrix
nifi
nifi-registry
wordpress
)

for c in ${CHARTS[@]}; do
    helm package $c
done

##