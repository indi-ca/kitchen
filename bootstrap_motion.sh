#!/bin/bash

apt-get update
apt-get upgrade
apt-get install -y fail2ban git zsh finger tree
apt-get install -y build-essential
apt-get install -y unattended-upgrades openssh-server

# Mosh
apt-get install -y python-software-properties
add-apt-repository -y ppa:keithw/mosh
apt-get update
apt-get install -y mosh


# unattended-upgrades
# This is not idempotetic
sed -i '$ a\APT::Periodic::Unattended-Upgrade "1";' /etc/apt/apt.conf.d/10periodic


apt-get -y autoremove

shutdown -r now