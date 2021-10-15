#!/bin/bash
#set -e

# docker pull jenkins/jenkins:lts-jdk11

# docker run -p 8080:8080 -p 50000:50000 jenkins/jenkins:lts-jdk11

# docker run -d --name jenktest --mount type=bind,source="$(pwd)"/jenkins_home,target=/var/jenkins_home -p 8080:8080 -p 50000:50000 jenkins/jenkins:lts-jdk11

# 6094c88ba69d


# ansible localhost -m uri -a 'url=http://httpbin.org/response-headers?Set-Cookie=Foo%3Dbar&Set-Cookie=Baz%3Dqux'

# ansible -c local localhost -m uri -a "url=https://jenkins.devops.goziohealth.com/crumbIssuer/api/json validate_certs=no user='kerry.hatcher@goziohealth.com' password='11d0da02ef67a495093ce45789175a2446' method=GET"



# export crumb=$(curl -b cookie.txt -c cookie.txt -v -X GET http://$jenkins_URL/crumbIssuer/api/json --user admin:$(cat ./jenkins_home/secrets/initialAdminPassword) | jq '.crumb')


docker stop jenktest

rm ~/.jenkins-cli.yaml

rm -rf jenkins_hoome/*

sleep 8

docker start jenktest


#export jenkins_URL="localhost:8080"

#export crumb=$(curl -b cookie.txt -c cookie.txt -v -X GET http://$jenkins_URL/crumbIssuer/api/json --user admin:$(cat ./jenkins_home/secrets/initialAdminPassword) | jq -r '.crumb')

#curl -b cookie.txt -c cookie.txt -X POST -o APItoken.json http://$jenkins_URL/me/descriptorByName/jenkins.security.ApiTokenProperty/generateNewToken --data 'newTokenName=bootstrap' --user admin:$(cat ./jenkins_home/secrets/initialAdminPassword) -H "Jenkins-Crumb: $crumb" 

#export jenk_token=$(cat APItoken.json | jq -r '.data.tokenValue')

#echo $jenkins_URL
#echo $crumb
#echo $jenk_token

#rm APItoken.json

#rm cookie.txt