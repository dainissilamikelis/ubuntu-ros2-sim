#! /bin/sh 

# Exit on any error and enable verbose output
set -e

echo "Installing base ROSsource install/setup.bash2..."

export ROS_APT_SOURCE_VERSION=$(curl -s https://api.github.com/repos/ros-infrastructure/ros-apt-source/releases/latest | grep -F "tag_name" | awk -F\" '{print $4}')
curl -L -o /tmp/ros2-apt-source.deb "https://github.com/ros-infrastructure/ros-apt-source/releases/download/${ROS_APT_SOURCE_VERSION}/ros2-apt-source_${ROS_APT_SOURCE_VERSION}.$(. /etc/os-release && echo $VERSION_CODENAME)_all.deb" # If using Ubuntu derivates use $UBUNTU_CODENAME
sudo apt install /tmp/ros2-apt-source.deb
sudo apt update
sudo apt upgrade

echo "Installing ROS desktop"

sudo apt install ros-humble-desktop

echo "Installing ROS dev tools"

sudo apt install ros-dev-tools

echo "Setting up ROS"

source /opt/ros/humble/setup.bash
echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc

echo "ROS2 installation complete"
echo "You can proceed with testing [readme.md]"