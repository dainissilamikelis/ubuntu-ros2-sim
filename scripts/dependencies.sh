#!/bin/bash

# Exit on any error and enable verbose output
set -e

echo "Starting dependency installation..."

# Update package list
echo "Updating package list..."
sudo apt update

# Check udev status (allow failure)
echo "Checking udev status..."
systemctl status udev || echo "udev status check completed"

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

echo "All dependencies installed successfully!"
echo "Note: Run 'source ~/.bashrc' or restart your terminal to update PATH"sudo apt update
# checking status
systemctl status udev

# Install and configure systemd

sudo apt install -y systemd systemd-sysv
systemctl --version

# installing dependencies
sudo apt install software-properties-common
sudo add-apt-repository universe
sudo apt-get install udev
sudo apt-get install libudev-dev
sudo apt install default-jre
sudo apt install curl -y
sudo apt-get install git
sudo apt-get install gitk git-gui
sudo apt-get install curl lsb-release gnupg
sudo apt install python3-pip
pip install MAVProxy
echo "export PATH=\$PATH:$(python3 -m site --user-base)/bin" >> ~/.bashrc
source ~/.bashrc
sudo apt-get update