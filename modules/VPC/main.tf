resource "google_compute_network" "network1" {
  name=var.vpc.network_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "name" {
  name = var.vpc.subnet_name
  region = var.region
  network = google_compute_network.network1.id
  ip_cidr_range = var.vpc.ip
  private_ip_google_access = true

}

resource "google_compute_firewall" "name" {
  name = var.vpc.firewall_name
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