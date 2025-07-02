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
}


resource "null_resource" "generate_inventory" {
  depends_on = [google_compute_instance.vm1]

  provisioner "local-exec" {
    command = <<EOT
echo "[gcp]" > ../ansible-using-ssh/hosts
echo "gcloud-vm-using-atlantis-p1 ansible_host=${google_compute_instance.vm1.network_interface[0].access_config[0].nat_ip} ansible_user=rocky ansible_ssh_private_key_file=/home/atlantis/.atlantis/repos/yashwanthm998/atlantis/ssh_key.pub" >> ../ansible-using-ssh/hosts
EOT
  }
}

resource "null_resource" "run_ansible" {
  depends_on = [null_resource.generate_inventory]

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ../ansible-using-ssh/hosts ../ansible-using-ssh/site.yml"
  }
}