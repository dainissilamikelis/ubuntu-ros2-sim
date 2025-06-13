echo "Setting up arduPilot"

git clone --recursive https://github.com/ArduPilot/ardupilot.git
## temp fix for specigic pull request
git fetch origin pull/29850/head:pr-29850
git checkout 3c190762278d3db6013872bf61defbb81aa25693
##
cd ardupilot
Tools/environment_install/install-prereqs-ubuntu.sh -y
. ~/.profile

echo "Building sitl compter"
./waf configure --board sitl
./waf copter

