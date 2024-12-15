#!/bin/bash

# Filename: rpitx_offline_install.sh

# Check if script is run with sudo
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run with sudo" 
   exit 1
fi

# Absolute path to the backup archive
BACKUP_FILE="$1"

# Check if backup file is provided
if [ -z "$BACKUP_FILE" ]; then
    echo "Usage: sudo bash rpitx_offline_install.sh /path/to/rpitx_complete_backup.tar.gz"
    exit 1
fi

# Install dependencies
apt-get update
apt-get install -y cmake libusb-1.0-0-dev qt5-default libfftw3-dev \
                   build-essential git libc6-dev wiringpi librtlsdr-dev

# Extract rpitx
tar -xzvf "$BACKUP_FILE" -C ~

# Navigate and compile
cd ~/rpitx
mkdir -p build
cd build
cmake ..
make

echo "rpitx installation complete!"