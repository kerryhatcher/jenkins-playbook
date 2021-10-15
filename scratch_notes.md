Old token stuff: 


```


- name: Parse Token
  command: "jcli plugin install {{ jenk_token.name }}"
  loop: "{{ jenkins_plugins }}"
  args:
    creates: "~/.jenkins/plugins/{{ item.name }}.jpi"

- name: Setup API crumb
  command: "curl -b cookie.txt -c cookie.txt -v -X GET http://$jenkins_URL/crumbIssuer/api/json --user admin:{{ initalAdmin_result.stdout }} | jq -r '.crumb'"
  register: jenk_crumb
  when:
    - configure_jenkins

- name: Setup API token
  command: "curl -b cookie.txt -c cookie.txt -X POST -o APItoken.json http://$jenkins_URL/me/descriptorByName/jenkins.security.ApiTokenProperty/generateNewToken --data 'newTokenName=bootstrap' --user admin:{{ initalAdmin_result.stdout }} -H 'Jenkins-Crumb: {{ jenk_crumb.stdout }}'"
  register: jenk_token
  when:
    - configure_jenkins

```