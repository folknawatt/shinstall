#!/bin/bash

# Update and install packages
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt update && sudo apt upgrade -y
sudo apt install python3 python3-pip -y
sudo apt install python3-venv

# Create a virtual environment
rm -rf venv
python3 -m venv /home/ubuntu2/shinstall/python_test
source /home/ubuntu2/shinstall/python_test/bin/activate
python_dc/bin/python3 -m pip install -r /home/ubuntu2/shinstall/requirements/requirements.txt

# Copy .service files to systemd directory
sudo rsync -r -az --delete -vt -v /home/ubuntu2/shinstall/config/backend.service /etc/systemd/system/
sudo rsync -r -az --delete -vt -v /home/ubuntu2/shinstall/config/data.service /etc/systemd/system/

# Reload systemd
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