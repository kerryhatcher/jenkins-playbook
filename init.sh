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

#brew services start jenkins-lts

#- java -jar /var/cache/jenkins/war/WEB-INF/jenkins-cli.jar -s http://127.0.0.1:8080/ -auth admin:$(cat /var/lib/jenkins/secrets/initialAdminPassword) install-plugin configuration-as-code configuration-as-code-secret-ssm credentials aws-secrets-manager-credentials-provider mailer cloudbees-folder antisamy-markup-formatter build-timeout credentials-binding timestamper ws-cleanup ant gradle nodejs htmlpublisher workflow-aggregator github-branch-source pipeline-github-lib pipeline-stage-view copyartifact parameterized-trigger conditional-buildstep bitbucket git github ssh-slaves matrix-auth pam-auth ldap role-strategy active-directory authorize-project email-ext 

#$(cat /var/lib/jenkins/secrets/initialAdminPassword)

#~/.jenkins/secrets/initialAdminPassword