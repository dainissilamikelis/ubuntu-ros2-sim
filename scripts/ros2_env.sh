echo "Installing additional ardu pilot dependencies"
mkdir -p ~/ardu_ws/src
cd ~/ardu_ws
vcs import --recursive --input  https://raw.githubusercontent.com/ArduPilot/ardupilot/master/Tools/ros2/ros2.repos src

echo "Updating dependencies"
cd ~/ardu_ws
sudo apt update
sudo rosdep init
rosdep update
source /opt/ros/humble/setup.bash
echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
rosdep install --from-paths src --ignore-src -r -y

echo "Installing Micro XRCE-DDS-Gen"
cd ~/ardu_ws
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

## Starts failing here
echo "Building workspace"
cd ~/ardu_ws
colcon build --packages-up-to ardupilot_dds_tests

# colcon build --packages-up-to ardupilot_dds_tests --event-handlers=console_cohesion+
