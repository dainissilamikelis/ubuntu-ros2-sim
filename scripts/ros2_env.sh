ARDU_DIR=./ardu_ws
ARDU_SOURCE=./ardu_ws/src

echo "Installing additional ardu pilot dependencies"
mkdir -p $ARDU_SOURCE
cd $ARDU_DIR
vcs import --recursive --input  https://raw.githubusercontent.com/ArduPilot/ardupilot/master/Tools/ros2/ros2.repos src

echo "Updating dependencies"
cd $ARDU_DIR
sudo apt update
sudo rosdep init
rosdep update
source /opt/ros/humble/setup.bash
echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
rosdep install --from-paths src --ignore-src -r -y

echo "Installing Micro XRCE-DDS-Gen"
cd $ARDU_DIR
git clone --recurse-submodules https://github.com/ardupilot/Micro-XRCE-DDS-Gen.git
## this is for now experimental

# git clone https://github.com/ardupilot/Micro-XRCE-DDS-Gen.git
# cd Micro-XRCE-DDS-Gen
# git checkout tags/v4.5.1
# git submodule update --init --recursive

##
cd Micro-XRCE-DDS-Gen
./gradlew assemble
echo "export PATH=\$PATH:$PWD/scripts" >> ~/.bashrc
source ~/.bashrc


## Starts failing here
echo "Building workspace"
cd $ARDU_DIR
colcon build --packages-up-to ardupilot_dds_tests

# colcon build --packages-up-to ardupilot_dds_tests --event-handlers=console_cohesion+
