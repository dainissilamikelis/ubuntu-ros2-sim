echo "Removing ROS2"
# add click Y to proceed


sudo apt remove ~nros-humble-* && sudo apt autoremove
sudo apt remove ros2-apt-source
sudo apt update
sudo apt autoremove
sudo apt upgrade # Consider upgrading for packages previously shadowed.


sudo apt remove gz-harmonic && sudo apt autoremove