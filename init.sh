#!/bin/bash
set -e

ask() {
    local prompt default reply

    if [[ ${2:-} = 'Y' ]]; then
        prompt='Y/n'
        default='Y'
    elif [[ ${2:-} = 'N' ]]; then
        prompt='y/N'
        default='N'
    else
        prompt='y/n'
        default=''
    fi

    while true; do

        # Ask the question (not using "read -p" as it uses stderr not stdout)
        echo -n "$1 [$prompt] "

        # Read the answer (use /dev/tty in case stdin is redirected from somewhere else)
        read -r reply </dev/tty

        # Default?
        if [[ -z $reply ]]; then
            reply=$default
        fi

        # Check if the reply is valid
        case "$reply" in
            Y*|y*) return 0 ;;
            N*|n*) return 1 ;;
        esac

    done
}





if ask "Install xcode?"; then
    echo "Yes"
    xcode-select --install

    if ask "Xcode finshed installing?"; then
    echo "Yes"
    else
        echo "No"
        exit 1
    fi
else
    echo "No"

fi








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