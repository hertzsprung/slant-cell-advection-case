#!/bin/bash
set -e

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

# remove them
collapseEdges -constant -overwrite -collapseFaceSet zeroAreaFaces

# final sanity check
checkMesh -constant
