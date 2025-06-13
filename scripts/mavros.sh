#! /bin/sh
sudo apt update
sudo apt install -y \
  ros-humble-mavros \
  ros-humble-mavros-extras \
  geographiclib-tools

# download required geo data
sudo geographiclib-get-geoids egm96-5


source /opt/ros/humble/setup.bash
ros2 run mavros mavros_node