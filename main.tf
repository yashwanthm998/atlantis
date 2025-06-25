
terraform {
  required_providers {
    google = {
        source = "hashicorp/google"
        version = "6.40.0"
    }
  }
}

provider "google" {
    project = local.project_id
    zone = var.zone
    region = var.region
    credentials = file(local.credentials)
}

module "bucket_creation" {
  source               = "./modules/Buckets"
  project_id           = local.project_id
  zone                 = var.zone
  region               = var.region
  credentials          = local.credentials
  bucket_zone_location = var.bucket_zone_location
  image_name           = var.image_name
  image_source         = var.image_source
}

module "vm_creation" {
  source = "./modules/VM"
  project_id           = local.project_id
  zone                 = var.zone
  region               = var.region
  credentials          = local.credentials
  machine_type = var.machine_type
  network = var.network
  subnetwork = var.subnetwork
}

module "vpc_creation" {
  source = "./modules/VPC"
  project_id           = local.project_id
  zone                 = var.zone
  region               = var.region
  credentials          = local.credentials
}

locals {
  credentials = var.project_selector == "project1" ? var.credentials_1 : var.credentials_2
  project_id = var.project_selector == "project1" ? var.project_id_1 : var.project_id_2
}
 