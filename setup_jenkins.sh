#!/bin/bash
set -e

#jcli center watch --util-install-complete

wget http://localhost/jnlpJars/jenkins-cli.jar

curl -o APItoken.json -F http://127.0.0.1:8080/me/descriptorByName/jenkins.security.ApiTokenProperty/generateNewToken --data 'newTokenName=bootstrap' --user admin:$(cat ~/.jenkins/secrets/initialAdminPassword)



java -jar jenkins-cli.jar -s http://127.0.0.1:8080/ -auth admin:$(cat ~/.jenkins/secrets/initialAdminPassword) -webSocket help
java -jar jenkins-cli.jar -s http://127.0.0.1:8080/ -auth admin:$(cat ~/.jenkins/secrets/initialAdminPassword) -webSocket install-plugin configuration-as-code configuration-as-code-secret-ssm credentials aws-secrets-manager-credentials-provider mailer cloudbees-folder antisamy-markup-formatter build-timeout credentials-binding timestamper ws-cleanup ant gradle nodejs htmlpublisher workflow-aggregator github-branch-source pipeline-github-lib pipeline-stage-view copyartifact parameterized-trigger conditional-buildstep bitbucket git github ssh-slaves matrix-auth pam-auth ldap role-strategy active-directory authorize-project email-ext 

jcli plugin install configuration-as-code configuration-as-code-secret-ssm credentials aws-secrets-manager-credentials-provider
jcli center watch
jcli plugin install mailer cloudbees-folder antisamy-markup-formatter build-timeout credentials-binding timestamper ws-cleanup ant
jcli center watch
jcli plugin install gradle nodejs htmlpublisher workflow-aggregator github-branch-source pipeline-github-lib pipeline-stage-view
jcli center watch
jcli plugin install copyartifact parameterized-trigger conditional-buildstep bitbucket git github ssh-slaves
jcli center watch
jcli plugin install matrix-auth pam-auth ldap role-strategy active-directory authorize-project email-ext
jcli center watch
jcli plugin install ndroid-emulator analysis-core android-lint android-signing google-play-android-publisher junit fabric-beta-publisher
jcli center watch
jcli plugin installappcenter ios-device-connector rvm xcode-plugin saml ruby-runtime
jcli center watch
jcli restart -b