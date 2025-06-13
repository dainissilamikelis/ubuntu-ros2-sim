sudo apt update
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