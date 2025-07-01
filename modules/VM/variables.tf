variable "project_id" {
    description = "Your project id"
    type = string
}

variable "zone" {
  description = "Instance zone"
  type = string
}


variable "region" {
  description = "Instance region"
  type = string
}

variable "credentials" {
  description = "Path to your key.json"
  type = string
}

variable "vm" {
  type = object({
    vm_name = string
    machine_type = string
    network = string
    subnetwork = string
  })
}

variable "ssh-key" {
  type = string
}