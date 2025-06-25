resource "google_compute_instance" "vm1" {
  name = "gcloud-vm-using-atlantis"
  zone = var.zone
  machine_type = var.machine_type
  network_interface {
    network = var.network
    subnetwork = var.subnetwork
  }
  allow_stopping_for_update = true
  
  boot_disk {
    initialize_params {
      image = "rocky-linux-9-v20250611"
      size = 20
    }
  }
}