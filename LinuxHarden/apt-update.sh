#!/bin/sh

#replace old sources list with updated version
sed -i -e 's/us.archive.ubuntu.com\|security.ubuntu.com/old-releases.ubuntu.com/g' /etc/apt/sources.list

# update system
apt-get update && apt-get upgrade -y && apt-get dist-upgrade -y

#install unzip for scripts, and tiger for hardening

apt-get install unzip tiger 
