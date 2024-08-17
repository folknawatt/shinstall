#!/bin/bash

# Set default values for variables
dir=$(dirname "$0")

# Update and install packages
sudo apt update && sudo apt upgrade -y
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt update
sudo apt upgrade -y
# sudo apt install python3 python3-pip -y

sudo apt install python3.10
cd Python-3.10.13
dir=$(dirname "$0") 
cd ..

# Create a virtual environment
python3.10 -m venv /usr/local/python_test

# Activate the virtual environment
source /usr/local/python_test/bin/activate
pip install -r $dir/shinstall/requirements/requirements.txt

# Check if the necessary packages are installed
if ! pip freeze | grep -q 'Error'; then
    echo "Error: Failed to install"
    exit 1
fi

# Copy .service files to systemd directory
sudo rsync -r -az --delete -vt -v $dir/shinstall/config/backend.service /etc/systemd/system/
sudo rsync -r -az --delete -vt -v $dir/shinstall/config/data.service /etc/systemd/system/


# Reload systemd daemon and enable services
sudo systemctl daemon-reload
sudo systemctl enable backend.service
sudo systemctl enable data.service
sudo systemctl restart data.service

# Start service
sudo systemctl start backend.service
sudo systemctl start data.service

# # Check service status
# sudo systemctl status backend.service
# sudo systemctl status data.service