#!/bin/bash

# Update and install packages
apt update -y
apt install python3 python3-pip python3-venv -y

python3 -m venv /usr/local/python_test
# source /home/ubuntu2/shinstall/python_test/bin/activate
python3 -m pip install -r /home/ubuntu2/shinstall/requirements/requirements.txt

# Copy .service files to systemd directory
rsync -r -az --delete -vt -v /home/ubuntu2/shinstall/config/backend.service /etc/systemd/system/

systemctl enable backend.service
systemctl restart backend.service
