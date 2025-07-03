resource "google_compute_instance" "vm1" {
  for_each = {for vms in var.vm : vms.vm_name => vms}
  name         = each.value.vm_name
  zone         = var.zone
  machine_type = each.value.machine_type

  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "rocky-linux-9-v20250611"
      size  = 20
    }
  }
  network_interface{
    network = "default"
    access_config {
    }
  }
metadata = {
  ssh-keys = "rocky:${file("${var.ssh-key}")}"
}

  tags = ["ssh", "http-server", "https-server"]

provisioner "local-exec" {
  command = <<EOT
    ip=${self.network_interface[0].access_config[0].nat_ip}
    
    echo "[gcp]" > ansible/hosts
    echo "${each.value.vm_name} ansible_host=$ip ansible_user=rocky ansible_ssh_private_key_file=/home/atlantis/.atlantis/repos/yashwanthm998/atlantis/ssh" >> ansible/hosts
    echo "Waiting for SSH to be ready on $ip..."
    for i in {1..30}; do
      ssh -o StrictHostKeyChecking=no -i /home/atlantis/.atlantis/repos/yashwanthm998/atlantis/ssh rocky@$ip "echo SSH ready" && break
      echo "SSH not ready yet... retrying in 5s"
      sleep 5
    done

    ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ansible/hosts ansible/site.yml
  EOT
}

}

output "ext_ip" {
  value = google_compute_instance.vm1[each.key].access_config[0].nat_ip
}

