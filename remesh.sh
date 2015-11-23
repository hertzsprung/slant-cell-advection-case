#!/bin/bash
set -e

rm -rf [0-9]*
rm -rf constant/theta_init
rm -rf constant/polyMesh/sets
rm -rf constant/*Weights

blockMesh

# move all points beneath the surface up to the surface
# this creates cells with tiny volumes and faces with tiny areas
slantMesh

# find tiny cells
# we avoid using checkMesh for this because its tolerance is too strict
checkCellVolumes

# create a subset bigCells which contains all cells that aren't tinyCells
setSet -constant -noVTK -batch removeTinyCells

# update the mesh to remove tinyCells, and assign exposed faces to the ground patch
subsetMesh -patch ground -overwrite bigCells

# find any zeroAreaFaces
checkMesh -constant

# remove them if there are any
if [ -e constant/polyMesh/zeroAreaFaces]
then
	collapseEdges -constant -overwrite -collapseFaceSet zeroAreaFaces
fi

# final sanity check
checkMesh -constant

cp init/theta_init constant/
