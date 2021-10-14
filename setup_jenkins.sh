#!/bin/bash
set -e

#jcli center watch --util-install-complete

export jenkins_URL="localhost:8080"

wget http://$jenkins_URL/jnlpJars/jenkins-cli.jar



curl -X POST -o APItoken.json -F http://$jenkins_URL/me/descriptorByName/jenkins.security.ApiTokenProperty/generateNewToken --data 'newTokenName=bootstrap' --user admin:$(cat ~/.jenkins/secrets/initialAdminPassword) -H "Jenkins-Crumb: $(curl -v -X GET http://$jenkins_URL/crumbIssuer/api/json --user admin:$(cat ~/.jenkins/secrets/initialAdminPassword) | jq '.crumb')"



java -jar jenkins-cli.jar -s http:/$jenkins_URL/ -auth admin:$(cat ~/.jenkins/secrets/initialAdminPassword) -webSocket help
java -jar jenkins-cli.jar -s http:/$jenkins_URL/ -auth admin:$(cat ~/.jenkins/secrets/initialAdminPassword) -webSocket install-plugin configuration-as-code configuration-as-code-secret-ssm credentials aws-secrets-manager-credentials-provider mailer cloudbees-folder antisamy-markup-formatter build-timeout credentials-binding timestamper ws-cleanup ant gradle nodejs htmlpublisher workflow-aggregator github-branch-source pipeline-github-lib pipeline-stage-view copyartifact parameterized-trigger conditional-buildstep bitbucket git github ssh-slaves matrix-auth pam-auth ldap role-strategy active-directory authorize-project email-ext 

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