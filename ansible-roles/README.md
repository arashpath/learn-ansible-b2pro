# Creating a role from a playbook
1. Move the tasks into `tasks/main.yml` .
2. Move the handlers into `handlers/main.yml` .
3. If any tasks use the template module, ensure that the files required are in the templates directory. The src argument to the module is now relative to the templates directory; for example, `src=posts/example.sql` would evaluate to `roles/your.role/templates/posts/example.sql` .
4. If any tasks use the copy module, ensure that the files required are in the files directory. The src argument to the module is now relative to the files directory; for example, `src=tools/useful-tool` would evaluate to `roles/your.role/files/tools/useful-tool` .
5. Move any variables used in this role (in tasks or in templates)into `defaults/main.yml` .