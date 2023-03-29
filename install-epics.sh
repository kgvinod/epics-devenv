#!/bin/bash

# Download and install EPICS base
wget https://epics-controls.org/download/base/base-7.0.5.tar.gz -O epics-base.tar.gz
tar -xzf epics-base.tar.gz
rm epics-base.tar.gz
mv base-7.0.5 base
cd base
make -sj

# Download and install synApps
cd ..
wget https://www.aps.anl.gov/epics/download/modules/synApps/synApps_6_1.tar.gz -O synApps.tar.gz
tar -xzf synApps.tar.gz
rm synApps.tar.gz
mv synApps-6-1 synApps
cd synApps
make release
make -sj
