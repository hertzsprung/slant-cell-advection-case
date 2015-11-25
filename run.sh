#!/bin/bash
set -e
setVelocityField
setTheta
mv 0/theta 0/T
advectionFoam
setAdvectedTheta
sumFields -scale0 1 -scale1 -1 18000 T_diff 18000 T 0 theta

