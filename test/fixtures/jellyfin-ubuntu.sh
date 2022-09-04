#!/usr/bin/env bash

# https://jellyfin.org/docs/general/administration/installing.html
# Ubuntu

# Remove the old /etc/apt/sources.list.d/jellyfin.list file:
/etc/apt/sources.list.d/jellyfin.list

# Remove the old /etc/apt/sources.list.d/jellyfin.list file:
sudo rm /etc/apt/sources.list.d/jellyfin.list

# Install HTTPS transport for APT if you haven't already:
sudo apt install apt-transport-https

# Enable the Universe repository to obtain all the FFMpeg dependencies:
# If the above command fails you will need to install the following package software-properties-common.
# This can be achieved with the following command sudo apt-get install software-properties-common
sudo add-apt-repository universe

# If the above command fails you will need to install the following package software-properties-common.
# This can be achieved with the following command sudo apt-get install software-properties-common
software-properties-common

# If the above command fails you will need to install the following package software-properties-common.
# This can be achieved with the following command sudo apt-get install software-properties-common
sudo apt-get install software-properties-common

# Import the GPG signing key (signed by the Jellyfin Team):
curl -fsSL https://repo.jellyfin.org/ubuntu/jellyfin_team.gpg.key | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/debian-jellyfin.gpg

# Add a repository configuration at /etc/apt/sources.list.d/jellyfin.list:
/etc/apt/sources.list.d/jellyfin.list

# Add a repository configuration at /etc/apt/sources.list.d/jellyfin.list:
# Supported releases are bionic, cosmic, disco, eoan, and focal.
echo "deb [arch=$( dpkg --print-architecture )] https://repo.jellyfin.org/ubuntu $( lsb_release -c -s ) main" | sudo tee /etc/apt/sources.list.d/jellyfin.list

# Supported releases are bionic, cosmic, disco, eoan, and focal.
bionic

# Supported releases are bionic, cosmic, disco, eoan, and focal.
cosmic

# Supported releases are bionic, cosmic, disco, eoan, and focal.
disco

# Supported releases are bionic, cosmic, disco, eoan, and focal.
eoan

# Supported releases are bionic, cosmic, disco, eoan, and focal.
focal

# Update APT repositories:
sudo apt update

# Install Jellyfin:
sudo apt install jellyfin

# Manage the Jellyfin system service with your tool of choice:
sudo service jellyfin status
sudo systemctl restart jellyfin
sudo /etc/init.d/jellyfin stop

# Enable the Universe repository to obtain all the FFMpeg dependencies, and update repositories:
sudo add-apt-repository universe
sudo apt update

# Download the desired jellyfin and jellyfin-ffmpeg .deb packages from the repository.
jellyfin

# Download the desired jellyfin and jellyfin-ffmpeg .deb packages from the repository.
jellyfin-ffmpeg

# Download the desired jellyfin and jellyfin-ffmpeg .deb packages from the repository.
.deb

# Install the required dependencies:
sudo apt install at libsqlite3-0 libfontconfig1 libfreetype6 libssl1.0.0

# Install the downloaded .deb packages:
.deb

# Install the downloaded .deb packages:
sudo dpkg -i jellyfin_*.deb jellyfin-ffmpeg_*.deb

# Use apt to install any missing dependencies:
apt

# Use apt to install any missing dependencies:
sudo apt -f install

# Manage the Jellyfin system service with your tool of choice:
sudo service jellyfin status
sudo systemctl restart jellyfin
sudo /etc/init.d/jellyfin stop
