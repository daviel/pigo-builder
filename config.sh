#!/bin/bash

/debootstrap/debootstrap --second-stage
apt update
apt upgrade -y
apt-get install wget -y
wget -qO - http://archive.raspberrypi.org/debian/raspberrypi.gpg.key | apt-key add -
echo "deb http://archive.raspberrypi.org/debian/ buster main ui" > /etc/apt/sources.list.d/raspbian.list
apt update
# general requirements
apt-get install libraspberrypi-dev build-essential pkg-config git sed -y
