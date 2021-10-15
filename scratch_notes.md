Old token stuff: 


```
- name: Get user API token
  uri:
    url: http://localhost:8080/me/descriptorByName/jenkins.security.ApiTokenProperty/generateNewToken
    method: POST
    return_content: yes
    user: "admin"
    password: "{{ initalAdmin_result.stdout }}"
    force_basic_auth: yes
    status_code: 200
    headers:
      Cookie: "{{ jenk_crumb.cookies_string }}"
    body_format: form-urlencoded
    body:
    - [ newTokenName, bootstrap ]
  register: jenk_token
  when:
    - configure_jenkins

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