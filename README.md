# This is way to setup ROS2 + AruduPilot + Gazebo drone simulation

Prerequisites:
**Ubuntu 22.04** 

Based on this guide: https://ardupilot.org/dev/docs/ros2-gazebo.html

Step by step for clean installation

# Install ROS2
1. Go to ROS2 Humble url https://docs.ros.org/en/humble/index.html


# ROS2 TEST 
Talker-listener
If you installed ros-humble-desktop above you can try some examples.

In one terminal, source the setup file and then run a C++ talker:

source /opt/ros/humble/setup.bash
ros2 run demo_nodes_cpp talker
In another terminal source the setup file and then run a Python listener:

source /opt/ros/humble/setup.bash
ros2 run demo_nodes_py listener
You should see the talker saying that it’s Publishing messages and the listener saying I heard those messages. This verifies both the C++ and Python APIs are working properly. Hooray!

# Verifying ROS2 installation

``` printenv | grep -i ROS ```
expected outcome

ROS_VERSION=2
ROS_PYTHON_VERSION=3
ROS_DISTRO=humble


# Test microxrceddsgen installation:

source ~/.bashrc

**expected outcome**
```
microxrceddsgen -help
# microxrceddsgen usage:
#     microxrceddsgen [options] <file> [<file> ...]
#     where the options are:
#             -help: shows this help
#             -version: shows the current version of eProsima Micro XRCE-DDS Gen.
#             -example: Generates an example.
#             -replace: replaces existing generated files.
#             -ppDisable: disables the preprocessor.
#             -ppPath: specifies the preprocessor path.
#             -I <path>: add directory to preprocessor include paths.
#             -d <path>: sets an output directory for generated files.
#             -t <temp dir>: sets a specific directory as a temporary directory.
#             -cs: IDL grammar apply case sensitive matching.
#     and the supported input files are:
#     * IDL files.
```
# Test ardu setup 
```
cd ~/ardu_ws
source ./install/setup.bash
colcon test --executor sequential --parallel-workers 0 --base-paths src/ardupilot --event-handlers=console_cohesion+
colcon test-result --all --verbose
```


cd ~/ardupilot/ArduCopter
../Tools/autotest/sim_vehicle.py -v ArduCopter -f quad --console --map