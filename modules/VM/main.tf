resource "google_compute_instance" "vm1" {

  for_each = {for vm in var.vm.instance : vm.vm_name => vm}
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
}
