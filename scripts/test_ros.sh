# open a new terminal and run this script

gnome-terminal -- bash -c "ros2 run demo_nodes_cpp talker; exec bash"
gnome-terminal -- bash -c "ros2 run demo_nodes_py listener; exec bash"

# wait for 30seconds and close