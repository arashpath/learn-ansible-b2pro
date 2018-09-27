# Creating a role from a playbook
1. Move the tasks into `tasks/main.yml` .
2. Move the handlers into `handlers/main.yml` .
3. If any tasks use the template module, ensure that the files required are in the templates directory. The src argument to the module is now relative to the templates directory; for example, `src=posts/example.sql` would evaluate to `roles/your.role/templates/posts/example.sql` .
4. If any tasks use the copy module, ensure that the files required are in the files directory. The src argument to the module is now relative to the files directory; for example, `src=tools/useful-tool` would evaluate to `roles/your.role/files/tools/useful-tool` .
5. Move any variables used in this role (in tasks or in templates)into `defaults/main.yml` .

## Downloading Existing Roles from Ansible Galaxy 
use `ansible-galaxy install <role> –p <directory>`
> eg. `ansible-galaxy install geerlingguy.git –p roles`

Create a play book `provisioning/playbook.yml`
```
---
- hosts: all
  roles:
    - geerlingguy.git
```

## Creating a new role
use `ansible-galaxy init <name.role> --init-path=<PATH>`
> eg. `ansible-galaxy init mheap.common --init-path=provisioning/roles/`

### Meaning of each folder and it's functionality 
* Every role should start with a **README.md** file. Explain the purpose of the role, why it has been developed instead of using an existing tool, and any variables that will be customizable in the role.
* **defaults/main.yml** is a configuration file that you can use to define default values for variables used in your role. You can also define variables in `vars/main.yml` that will override anything in `defaults/main.yml` , as it has a much higher precedence. For example, variables located in `vars/main.yml` will override variables defined when gathering facts about a system, but variables located in `defaults/main.yml` will not. You’ll learn more about variable precedence in Chapter 5 .
* **files** is where you place files required during your role's execution. This could be static assets, configuration files—any type of file. These files cannot be manipulated at all, however, just copied.
* **handlers/main.yml** is where you will define handlers like restart nginx . Collecting all of the available handlers in one place makes it really easy for people who use your module to see what actions are available to them. Handlers can be called in the same role, from other roles, and from the calling playbook.
* **meta/main.yml** is the metadata file for your role. You use this file to define the metadata that Ansible Galaxy uses if you publish your module. You can also define things like minimum Ansible version, supported platforms, and any dependencies that your role has.
* **tasks/main.yml** is where you'll spend most of your time. This is the tasks section that was in your playbook. Any actions defined in this file will be executed by Ansible when your role runs.
* **templates** contains any files that you need to have processed by the jinja2 templating language in order to interpolate any variables required in the file before copying them onto your target system.
* **tests** is a directory where you should create test playbooks that consume your role. This is primarily used when testing your role automatically using a continuous integration system, such as Jenkins or Travis CI. A continuous integration system is a tool that watches projects for changes and triggers actions automatically. These actions typically run tests for the project, but can do whatever you can express in a script.