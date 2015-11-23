#!/bin/bash
set -e
slantMesh
checkCellVolumes
setSet -constant -noVTK -batch removeTinyCells
subsetMesh -patch ground -overwrite bigCells
checkMesh -constant
collapseEdges -constant -overwrite -collapseFaceSet zeroAreaFaces
