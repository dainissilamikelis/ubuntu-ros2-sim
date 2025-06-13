#!/bin/bash

# Exit on any error and enable verbose output
set -e

echo "Installing additional ArduPilot dependencies..."

# Create workspace
echo "Creating ArduPilot workspace..."
mkdir -p ~/ardu_ws/src
cd ~/ardu_ws

# Import ROS2 repositories
echo "Importing ROS2 repositories..."
vcs import --recursive --input https://raw.githubusercontent.com/ArduPilot/ardupilot/master/Tools/ros2/ros2.repos src

echo "Updating dependencies..."
cd ~/ardu_ws
sudo apt update

# Initialize rosdep (handle case where it's already initialized)
echo "Initializing rosdep..."
if ! rosdep init 2>/dev/null; then
    echo "rosdep already initialized, skipping..."
fi

echo "Updating rosdep..."
rosdep update

# Source ROS2 environment
echo "Sourcing ROS2 environment..."
source /opt/ros/humble/setup.bash

# Check if ROS setup is already in bashrc to avoid duplicates
if ! grep -q "source /opt/ros/humble/setup.bash" ~/.bashrc; then
    echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
    echo "Added ROS setup to ~/.bashrc"
else
    echo "ROS setup already configured in ~/.bashrc"
fi

# Install dependencies
echo "Installing workspace dependencies..."
rosdep install --from-paths src --ignore-src -r -y

echo "Installing Micro XRCE-DDS-Gen..."
cd ~/ardu_ws

# Clean up if exists
if [ -d "Micro-XRCE-DDS-Gen" ]; then
    echo "Removing existing Micro-XRCE-DDS-Gen..."
    rm -rf Micro-XRCE-DDS-Gen
fi

# Clone and use stable version
git clone --recurse-submodules https://github.com/ardupilot/Micro-XRCE-DDS-Gen.git
cd Micro-XRCE-DDS-Gen

# Use stable version instead of master
echo "Checking out stable version v4.5.1..."
git checkout tags/v4.5.1
git submodule update --init --recursive

echo "Building Micro XRCE-DDS-Gen..."
./gradlew assemble

# Add to PATH if not already present
XRCE_PATH="$PWD/scripts"
if ! grep -q "$XRCE_PATH" ~/.bashrc; then
    echo "export PATH=\$PATH:$XRCE_PATH" >> ~/.bashrc
    echo "Added Micro XRCE-DDS-Gen to PATH"
else
    echo "Micro XRCE-DDS-Gen already in PATH"
fi

# Export for current session
export PATH=$PATH:$XRCE_PATH

echo "Building workspace with optimized settings..."
cd ~/ardu_ws

# Build with limited parallelism to prevent segfaults and memory issues
echo "Building ArduPilot DDS packages (this may take several minutes)..."
MAKEFLAGS="-j2" colcon build \
    --packages-up-to ardupilot_dds_tests \
    --event-handlers console_direct+ \
    --parallel-workers 2 \
    --cmake-args -DCMAKE_BUILD_TYPE=Release \
    --continue-on-error

# Set up workspace environment
echo "Setting up workspace environment..."
if [ -f "install/setup.bash" ]; then
    source install/setup.bash
    if ! grep -q "source ~/ardu_ws/install/setup.bash" ~/.bashrc; then
        echo "source ~/ardu_ws/install/setup.bash" >> ~/.bashrc
        echo "Added workspace setup to ~/.bashrc"
    else
        echo "Workspace setup already configured in ~/.bashrc"
    fi
else
    echo "Warning: Workspace build may have failed - install/setup.bash not found"
fi

echo "ROS2 ArduPilot environment setup complete!"
echo "Note: Run 'source ~/.bashrc' or restart your terminal to load all environments"
echo "Workspace location: ~/ardu_ws"
