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





if ask "Disable sudo password?"; then
    echo "Yes"
    echo "$(whoami) ALL = (ALL) NOPASSWD: ALL" | sudo EDITOR='tee -a' visudo
    #sudo echo "$(whoami) ALL = (ALL) NOPASSWD: ALL" > /private/etc/sudoers.d/jenkins
else
    echo "No"

fi

if ask "Disable Sleep?"; then
    echo "Yes"
    sudo systemsetup -setcomputersleep Never

else
    echo "No"

fi




if ask "Disable Gatekeeper?"; then
    echo "Yes"
    sudo spctl --master-disable

else
    echo "No"

fi



if ask "Install xcode?"; then
    echo "Yes"
    xcode-select --install
    # echo "Checking Xcode CLI tools"
    # Only run if the tools are not installed yet
    # To check that try to print the SDK path
    # xcode-select -p &> /dev/null
    # if [ $? -ne 0 ]; then
    #     echo "Xcode CLI tools not found. Installing them..."
    #     touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress;
    #     PROD=$(softwareupdate -l |
    #         grep "\*.*Command Line" |
    #         head -n 1 | awk -F"*" '{print $2}' |
    #         sed -e 's/^ *//' |
    #         tr -d '\n')
    #     softwareupdate -i "$PROD" -v;
    else
        echo "Xcode CLI tools OK"
    fi

    if ask "Xcode finshed installing?"; then
        echo "Yes"
    else
        echo "No"
        exit 1
    fi
else
    echo "No"

fi





if ask "Run playbook?"; then
    echo "Yes"

    export PATH="$HOME/Library/Python/3.8/bin:/opt/homebrew/bin:$PATH"
    
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py

    python3 get-pip.py --user

    python3 -m pip install --upgrade pip

    if [ -d "~/jenkins-playbook" ] 
    then
        echo "jenkins-playbook found, updating" 
        cd ~/jenkins-playbook
        git pull
    else
        echo "No folder, cloning" 
        git clone https://github.com/kerryhatcher/jenkins-playbook.git ~/jenkins-playbook
        cd ~/jenkins-playbook
    fi

    
    cd ~/jenkins-playbook
    
    make setup

    . venv/bin/activate

    which python3

    which python

    which pip3

    which pip

    pip3 install --upgrade pip

    pip3 install -r requirements.txt

    ansible-galaxy install -r requirements.yml

   

    if [[ -z $ansible_become_password ]]; then
        ansible-playbook main.yml
    else
        ansible-playbook main.yml --ask-become-pass
    fi

else
    echo "No"

fi


if ask "Install Install Android SDK components?"; then
    echo "Yes"
    sdkmanager --update
    sdkmanager "platform-tools" "platforms;android-28"
    echo "export ANDROID_HOME=/usr/local/share/android-sdk" >> ~/.bash_profile
    echo "export ANDROID_NDK_HOME=/usr/local/share/android-ndk" >> ~/.bash_profile
    echo "export LC_ALL=en_US.UTF-8" >> ~/.bash_profile
    echo "export LANG=en_US.UTF-8" >> ~/.bash_profile
    source ~/.bash_profile

else
    echo "No"

fi

if ask "Disable Gradle Daemon?"; then
    echo "Yes"
    echo "org.gradle.daemon=false" ~/.gradle/gradle.properties

else
    echo "No"

fi

# if ask "Install Ruby/RVM?"; then
#     echo "Yes"
#     curl -sSL https://get.rvm.io | bash -s stable
#     source ~/.rvm/scripts/rvm
#     rvm install 2.6.3
#     gem install bundler -v 2.0.2

# else
#     echo "No"

# fi

if ask "Install all supported Xcode and CLI tools?"; then
    echo "Yes"
    #sudo gem install xcode-install
    xcversion install 11.1
    xcversion install 11.3.1
    xcversion install 11.4.1
    xcversion install 12.4
    xcversion install 12.5
    sudo xcode-select --switch /Library/Developer/CommandLineTools
    sudo xcodebuild -license accept
else
    echo "No"

fi