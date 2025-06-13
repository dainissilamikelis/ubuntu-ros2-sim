#!/bin/bash

# Exit on any error and enable verbose output
set -e

echo "Starting dependency installation..."

# Update package list
echo "Updating package list..."
sudo apt update

# Install and configure systemd
echo "Installing systemd..."
sudo apt install -y systemd systemd-sysv
systemctl --version

# Add universe repository
echo "Adding universe repository..."
sudo apt install -y software-properties-common
sudo add-apt-repository -y universe

# Update after adding repository
echo "Updating package list after adding repository..."
sudo apt update

# Install all packages in logical groups
echo "Installing system utilities..."
sudo apt install -y \
    udev \
    libudev-dev \
    curl \
    lsb-release \
    gnupg

echo "Installing development tools..."
sudo apt install -y \
    git \
    gitk \
    git-gui \
    default-jre

echo "Installing Python tools..."
sudo apt install -y python3-pip

echo "Installing MAVProxy..."
pip install MAVProxy

# Add Python user bin to PATH if not already present
echo "Configuring PATH..."
PYTHON_USER_BIN="$(python3 -m site --user-base)/bin"
if ! grep -q "$PYTHON_USER_BIN" ~/.bashrc; then
    echo "export PATH=\$PATH:$PYTHON_USER_BIN" >> ~/.bashrc
    echo "Added Python user bin to PATH"
else
    echo "Python user bin already in PATH"
fi

# # Add the OSRF package signing key
# wget https://packages.osrfoundation.org/gazebo.key -O - | sudo apt-key add -

# # Add Gazebo package repository for Ubuntu 22.04 (jammy)
# echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable jammy main" | \
#   sudo tee /etc/apt/sources.list.d/gazebo-stable.list

sudo apt update
sudo apt install ros-humble-ros-gz-sim

echo "All dependencies installed successfully!"
echo "Note: Run 'source ~/.bashrc' or restart your terminal to update PATH"sudo apt update

