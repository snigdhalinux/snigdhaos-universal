#!/bin/bash

# Author: Eshan Roy
# URL : https://eshanized.github.io

set -e

# Check if the script is being run as root
if [[ $EUID -ne 0 ]]; then
   echo ""
   echo "You must be run as root!" 
   echo ""
   exit 1
fi

# Define file paths
current_pacman_conf="/etc/pacman.conf"
default_pacman_conf="/etc/pacman.conf.default"

# Check if the default pacman.conf exists
if [ ! -f "$default_pacman_conf" ]; then
    echo "Default pacman.conf file not found. Aborting."
    exit 1
fi

# Create a backup of the current pacman.conf
timestamp=$(date +"%Y%m%d_%H%M%S")
backup_pacman_conf="/etc/pacman.conf_$timestamp"
cp "$current_pacman_conf" "$backup_pacman_conf"

# Replace current pacman.conf with the default pacman.conf
cp "$default_pacman_conf" "$current_pacman_conf"

echo ""
echo "Pacman.conf configuration has been reset."
echo "Backup created: $backup_pacman_conf"
echo ""