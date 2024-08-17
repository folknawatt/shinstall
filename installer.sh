#!/bin/bash

# Update and install packages
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt update && sudo apt upgrade -y
sudo apt install python3 python3-pip -y

sudo apt install python3.10

# Create a virtual environment
python3.10 -m venv /usr/local/python_test

# Activate the virtual environment
source /usr/local/python_test/bin/activate
/usr/local/python_dc/bin/python3 -m pip install -r /shinstall/requirements/requirements.txt


# Copy .service files to systemd directory
sudo rsync -r -az --delete -vt -v /shinstall/config/backend.service /etc/systemd/system/
sudo rsync -r -az --delete -vt -v /shinstall/config/data.service /etc/systemd/system/

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