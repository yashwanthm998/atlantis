resource "google_compute_instance" "vm1" {

  name         = var.vm.vm_name
  zone         = var.zone
  machine_type = var.vm.machine_type

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
      sleep 60
      echo "[gcp]" > ansible/hosts
      echo "gcloud-vm-using-atlantis-p1 ansible_host=${self.network_interface[0].access_config[0].nat_ip} ansible_user=rocky ansible_ssh_private_key_file=/home/atlantis/.atlantis/repos/yashwanthm998/atlantis/ssh" >> ansible/hosts
      ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ansible/hosts ansible/site.yml
    EOT
  }
}

output "ext_ip" {
  value = google_compute_instance.vm1.network_interface[0].access_config[0].nat_ip
}

