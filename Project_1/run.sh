#!/bin/bash

set -e

# Run Terraform apply
echo "Running Terraform..."
terraform apply -auto-approve

# Extract output as JSON
echo "Extracting VM info..."
VM_JSON=$(terraform output -json vm_info)

# Prepare Ansible hosts file
echo "Generating Ansible inventory..."
echo "" > ansible/hosts

echo "$VM_JSON" | jq -r 'to_entries[] | "\(.key) ansible_host=\(.value.ip) ansible_user=\(.value.username) ansible_ssh_private_key_file=/home/atlantis/.atlantis/repos/yashwanthm998/atlantis/ssh"' >> ansible/hosts

  echo "Waiting for SSH on $host..."
  for i in {1..30}; do
    ssh -o StrictHostKeyChecking=no -i ./ssh "$user@$host" "echo SSH Ready" && break
    echo "SSH not ready yet... retrying in 5s"
    sleep 5
  done
done < ansible/hosts

# Run Ansible playbook
echo "Running Ansible..."
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ansible/hosts ansible/site.yml
