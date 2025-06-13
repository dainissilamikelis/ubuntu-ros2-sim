#! /bin/sh 
# This script sets up the locale to ensure UTF-8 encoding is used.
# It is useful for applications that require UTF-8 encoding, such as Python.
# This seems likely optionally 

locale  # check for UTF-8

sudo apt update && sudo apt install locales
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8

locale  # verify settings