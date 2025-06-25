resource "google_compute_network" "network1" {
  name="gcloud-network-using-atlantis"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "name" {
  name = "atlantis-subnetwork"
  region = var.region
  network = google_compute_network.network1.id
  ip_cidr_range = "10.1.0.0/24"
  private_ip_google_access = true

}

resource "google_compute_firewall" "name" {
  name = "gcloud-firewall-atlantis"
  network = google_compute_network.network1.id

allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
  }

  allow {
    protocol = "udp"
    ports = [ "161" ]
  }

  source_ranges = [ "14.97.94.230/32" ]
  priority = 500

}