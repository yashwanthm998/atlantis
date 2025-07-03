resource "google_compute_instance" "vm1" {
  for_each = {for vms in var.vm : vms.vm_name => vms}
  name         = each.value.vm_name
  zone         = var.zone
  machine_type = each.value.machine_type

  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = each.value.image
      size  = 20
    }
  }
  network_interface{
    network = "default"
    access_config {
    }
  }
metadata = {
  ssh-keys = "${each.value.username}:${file("${var.ssh-key}")}"
}

  tags = ["ssh", "http-server", "https-server"]


# provisioner "local-exec" {
#   command = <<EOT
#     ip=${self.network_interface[0].access_config[0].nat_ip}
#     ssh-keygen -R "$ip" || true
#     echo "${each.value.vm_name} ansible_host=$ip ansible_user=${each.value.username} ansible_ssh_private_key_file=/home/atlantis/.atlantis/repos/yashwanthm998/atlantis/ssh" >> ansible/hosts
#     echo "Waiting for SSH to be ready on $ip..."
#     for i in {1..30}; do
#       ssh -o StrictHostKeyChecking=no -i /home/atlantis/.atlantis/repos/yashwanthm998/atlantis/ssh ${each.value.vm_name}@$ip "echo SSH ready" && break
#       echo "SSH not ready yet... retrying in 5s"
#       sleep 5
#     done

#     ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ansible/hosts ansible/site.yml || true
#   EOT
# }

}

output "vm_info" {
  value = {
    for name, vm in google_compute_instance.vm1 :
    name => {
      ip       = vm.network_interface[0].access_config[0].nat_ip
      username = var.vm[0].username
    }
  }
}



