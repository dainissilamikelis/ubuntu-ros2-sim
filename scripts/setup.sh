#! /bin/bash 
# maybe setup different mirror that LV ?

# this is likely optional
echo "Setting up locales"
../scripts/locales.sh
echo "Locales setup done"

echo "Installing dependencies"
../scripts/dependencies.sh
echo "Installing dependencies done"

echo "Installing ROS2 Done"
../scripts/ros2.sh
echo "Installing ROS2 Humble done"

echo "Installing arduPilot"
 ../scripts/ardupilot.sh
echo "Installing ArduPilot done"

echo "Setting up ROS2 environment"
../scripts/ros2_env.sh
echo "Setting up ROS2 environment done"

echo "Setting up arduPilot with ROS2"
../scripts/ardu_ros2.sh
echo "Setting up ArduPilot with ROS2 done"



echo "Setting up GAZEBO"
../scripts/gazebo.sh
echo "Setting up GAZEBO done"


## Run stuff
source install/setup.bash
ros2 launch ardupilot_gz_bringup iris_runway.launch.py

ros2 launch ardupilot_gz_bringup iris_mini.launch.py