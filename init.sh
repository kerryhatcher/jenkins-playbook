#!/bin/bash
#

set -e

#xcode-select --install

curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3 get-pip.py --user

export PATH="$HOME/Library/Python/3.8/bin:/opt/homebrew/bin:$PATH"

#  python -m pip install --user ansible
sudo pip3 install --upgrade pip

pip3 install -r requirements.txt

ansible-galaxy install -r requirements.yml

ansible-playbook main.yml --ask-become-pass