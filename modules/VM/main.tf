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
  ssh-keys = "${each.value.username}:${file("${var.ssh-key}")}"
}

  tags = ["ssh", "http-server", "https-server"]

provisioner "remote-exec" {
  inline = [ "echo SSH is ready on $(hostname)" ]

  connection {
    type        = "ssh"
    user        = each.value.username
    private_key = file("/home/atlantis/.atlantis/repos/yashwanthm998/atlantis/ssh")
    host        = self.network_interface[0].access_config[0].nat_ip
  }
}


provisioner "local-exec" {
  command = <<EOT
    ip=${self.network_interface[0].access_config[0].nat_ip}
    echo "[gcp]" > ansible/hosts
    echo "${each.value.vm_name} ansible_host=$ip ansible_user=${each.value.username} ansible_ssh_private_key_file=/home/atlantis/.atlantis/repos/yashwanthm998/atlantis/ssh" >> ansible/hosts
    ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ansible/hosts ansible/site.yml
  EOT
}


}



