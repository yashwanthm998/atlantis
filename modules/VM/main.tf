resource "google_compute_disk" "extra_disk" {
  for_each = {for vms in var.vm : vms.vm_name => vms}
  name = "${each.key}-extra-disk"
  type = "pd-standard"
  zone = var.zone
  size = 50
}


resource "google_compute_instance" "vm1" {
  for_each = {for vms in var.vm : vms.vm_name => vms}
  name         = each.value.vm_name
  zone         = var.zone
  machine_type = each.value.machine_type

  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = each.value.image
      size  = 20
    }
  }
  attached_disk {
    source      = google_compute_disk.extra_disk[each.key].self_link
    device_name = "extra-disk"
    mode        = "READ_WRITE"
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
}

output "vm_info" {
  value = {
    for name, vm in google_compute_instance.vm1 :
    name => {
      ip       = vm.network_interface[0].access_config[0].nat_ip
      username = split(":", vm.metadata["ssh-keys"])[0]
    }
  }
}


 

