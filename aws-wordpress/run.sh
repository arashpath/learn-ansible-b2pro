#!/bin/bash

mkdir ~/.aws
cat <<EOF > ~/.aws/credentials
[default]
aws_access_key_id = <ACCESS_KEY_ID>
aws_secret_access_key =  <SECRET_ACCESS_KEY>
region = ap-southeast-1
EOF

ansible-playbook -i 'localhost,' manage-instances.yml

wget -c "https://raw.githubusercontent.com/ansible/ansible/devel/contrib/inventory/ec2.py"
wget -c "https://raw.githubusercontent.com/ansible/ansible/devel/contrib/inventory/ec2.ini"

sed -i '/rds = False/s/^#//
/elasticache = False/s/^#//' ec2.ini

chmod 006 ~/Downloads/aws-ansible.pem
ssh ubuntu@<awsVMip> -i ~/Downloads/aws-ansible.pem

ansible-playbook -i ec2.py -u ubuntu --key-file ~/Downloads/aws-ansible.pem install-wordpress.yml
