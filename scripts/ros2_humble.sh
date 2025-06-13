#!/bin/bash

# Exit on any error and enable verbose output
set -e

echo "Installing base ROSsource install/setup.bash2..."

# Get the latest ROS APT source version
echo "Fetching latest ROS APT source version..."
export ROS_APT_SOURCE_VERSION=$(curl -s https://api.github.com/repos/ros-infrastructure/ros-apt-source/releases/latest | grep -F "tag_name" | awk -F\" '{print $4}')
echo "Latest version: $ROS_APT_SOURCE_VERSION"

# Download and install ROS APT source
echo "Downloading ROS APT source package..."
curl -L -o /tmp/ros2-apt-source.deb "https://github.com/ros-infrastructure/ros-apt-source/releases/download/${ROS_APT_SOURCE_VERSION}/ros2-apt-source_${ROS_APT_SOURCE_VERSION}.$(. /etc/os-release && echo $VERSION_CODENAME)_all.deb"

echo "Installing ROS APT source..."
sudo apt install -y /tmp/ros2-apt-source.deb

echo "Updating package list..."
sudo apt update

echo "Upgrading existing packages..."
sudo apt upgrade -y

echo "Installing ROS Humble Desktop..."
sudo apt install -y ros-humble-desktop

echo "Installing ROS development tools..."
sudo apt install -y ros-dev-tools

echo "Setting up ROS environment..."
source /opt/ros/humble/setup.bash

# Check if ROS setup is already in bashrc to avoid duplicates
if ! grep -q "source /opt/ros/humble/setup.bash" ~/.bashrc; then
    echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
    echo "Added ROS setup to ~/.bashrc"
else
    echo "ROS setup already configured in ~/.bashrc"
fi

# Clean up downloaded file
echo "Cleaning up temporary files..."
rm -f /tmp/ros2-apt-source.deb

echo "ROS2 installation complete!"
echo "Note: Run 'source ~/.bashrc' or restart your terminal to load ROS environment"
echo "You can proceed with testing [readme.md]"