variable "project_id_1" {
    description = "Your project id"
    type = string
}

variable "project_id_2" {
    description = "Your project id"
    type = string
}

variable "project_selector" {
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

variable "credentials_1" {
  type = string
}

variable "credentials_2" {
  type = string
}

variable "bucket" {
  type = object({
    bucket_name = string
    bucket_zone_location = string
    storage_class = string
    image_name = string
    image_source = string 
  })
  
}

variable "vm" {
  type = object({
    vm_name = string
    machine_type = string
    network = string
    subnetwork = string
  })
}

variable "vpc" {
  type = object({
    network_name = string
    subnet_name = string
    ip = string
    firewall_name = string
  })
}

variable "sa" {
  type = object({
    account_id = string
    display_name = string
  })
}

variable "module_selector" {
  type = any
}
