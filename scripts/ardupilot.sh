#!/bin/bash

# Exit on any error and enable verbose output
set -e

echo "Setting up ArduPilot..."

# Check if ardupilot directory already exists
if [ -d "ardupilot" ]; then
    echo "ArduPilot directory already exists. Removing and re-cloning..."
    rm -rf ardupilot
fi

echo "Cloning ArduPilot repository..."
git clone --recursive https://github.com/ArduPilot/ardupilot.git

echo "Entering ArduPilot directory..."
cd ardupilot

# Temp fix for specific pull request
echo "Applying temporary fix for specific pull request..."
git fetch origin pull/29850/head:pr-29850
git checkout 3c190762278d3db6013872bf61defbb81aa25693

echo "Installing ArduPilot prerequisites..."
Tools/environment_install/install-prereqs-ubuntu.sh -y

echo "Sourcing profile to update environment..."
source ~/.profile

echo "Building SITL copter..."
./waf configure --board sitl
./waf copter

echo "ArduPilot SITL copter build complete!"
echo "You can now run the simulator from the ardupilot directory"

