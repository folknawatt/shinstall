#!/bin/bash

# Set default values for variables
dir=$(dirname "$0")

# Update and install packages
# sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt update && sudo apt upgrade -y
sudo apt install python3 python3-pip -y
sudo apt install python3-venv

python3 -m venv /urs/local/python_test
source /urs/local/python_test/bin/activate
python_test/bin/python3 -m pip install -r /home/ubuntu2/shinstall/requirements/requirements.txt

# Copy .service files to systemd directory
sudo rsync -r -az --delete -vt -v /home/ubuntu2/shinstall/config/backend.service /etc/systemd/system/
sudo rsync -r -az --delete -vt -v /home/ubuntu2/shinstall/config/data.service /etc/systemd/system/


sudo systemctl daemon-reload
sudo systemctl enable backend.service
sudo systemctl enable data.service
sudo systemctl restart data.service
sudo systemctl start backend.service
sudo systemctl status backend.service
sudo systemctl status data.service
