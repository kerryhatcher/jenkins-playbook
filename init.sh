#!/bin/bash
set -e

curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3 get-pip.py --user

cd

rm -rf jenkins-playbook

git clone https://github.com/kerryhatcher/jenkins-playbook.git

cd jenkins-playbook

export PATH="$HOME/Library/Python/3.8/bin:/opt/homebrew/bin:$PATH"

#  python -m pip install --user ansible
sudo pip3 install --upgrade pip

pip3 install -r requirements.txt

ansible-galaxy install -r requirements.yml

ansible-playbook main.yml --ask-become-pass