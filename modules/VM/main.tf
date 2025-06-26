resource "google_compute_instance" "vm1" {
  name = var.vm.vm_name
  zone = var.zone
  machine_type = var.vm.machine_type
  network_interface {
    network = "default"
  }
  allow_stopping_for_update = true
  
  boot_disk {
    initialize_params {
      image = "rocky-linux-9-v20250611"
      size = 20
    }
  }
}