#!/bin/bash
set -e

# Author : Eshan Roy <src.eshan@gmail.com>
# URL : https://eshanized.github.io

# Check if the script is being run as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root!"
    exit 1
fi

# Define repository URLs and names
repo_urls=(
    "https://snigdhalinux.github.io/$repo/$arch"
    # Add more repository URLs if needed
)

repo_names=(
    "hawkeye"
    # Add corresponding repository names
)

# Function to add or update repository configurations
update_pacman_conf() {
    for ((i=0; i<${#repo_urls[@]}; i++)); do
        if grep -q "${repo_names[i]}" /etc/pacman.conf; then
            sed -i "s|^\[${repo_names[i]}\].*|&\nServer = ${repo_urls[i]}|g" /etc/pacman.conf
        else
            echo -e "\n[${repo_names[i]}]\nServer = ${repo_urls[i]}" >> /etc/pacman.conf
        fi
    done
}

# Run the function to update pacman.conf
update_pacman_conf

echo ""
echo "Pacman.conf has been updated with Snigdha OS repository configurations."
echo ""
