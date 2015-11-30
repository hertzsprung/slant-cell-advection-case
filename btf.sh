#!/bin/bash
set -e

rm -rf [0-9]*
rm -rf constant/theta_init
rm -rf constant/polyMesh/sets
rm -rf constant/*Weights

blockMesh
terrainFollowingMesh
cp init/theta_init constant/
