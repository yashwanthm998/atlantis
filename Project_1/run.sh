#!/bin/bash

echo "Extracting IPs from terraform output..."

VM_JSON=$(terraform output -json vm_info)

echo "" > ansible/hosts
echo "$VM_JSON" | jq -r 'to_entries[] | "\(.key) ansible_host=\(.value.ip) ansible_user=\(.value.username) ansible_ssh_private_key_file=/home/atlantis/.atlantis/repos/yashwanthm998/atlantis/ssh"' >> ansible/hosts

echo "Running Ansible Playbook..."
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ansible/hosts ansible/site.yml
