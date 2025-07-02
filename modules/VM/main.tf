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

resource "google_compute_firewall" "allow-ssh" {
  name    = "allow-ssh"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh"]
}


resource "null_resource" "wait_for_ssh" {
  depends_on = [google_compute_instance.vm1]

  provisioner "local-exec" {
    command = <<EOT
      echo "Waiting for SSH to be available..."
      for i in {1..10}; do
        nc -zv ${google_compute_instance.vm1.network_interface[0].access_config[0].nat_ip} 22 && break
        echo "Retrying SSH in 10 seconds..."
        sleep 10
      done
    EOT
  }
}

# 📝 Generate Ansible inventory dynamically
resource "null_resource" "generate_inventory" {
  depends_on = [null_resource.wait_for_ssh]

  provisioner "local-exec" {
    command = <<EOT
echo "[gcp]" > ../ansible-using-ssh/hosts
echo "gcloud-vm-using-atlantis-p1 ansible_host=${google_compute_instance.vm1.network_interface[0].access_config[0].nat_ip} ansible_user=rocky ansible_ssh_private_key_file=/home/atlantis/.atlantis/repos/yashwanthm998/atlantis/ssh_key.pub" >> ../ansible-using-ssh/hosts
EOT
  }
}

# ▶️ Run Ansible Playbook
resource "null_resource" "run_ansible" {
  depends_on = [null_resource.generate_inventory]

  provisioner "local-exec" {
    command = <<EOT
      echo "Running Ansible playbook..."
      ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ../ansible-using-ssh/hosts ../ansible-using-ssh/site.yml
    EOT
  }
}