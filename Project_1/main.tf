
terraform {
    backend "gcs" {
    bucket = "my-atlantis-tfstate"
    prefix = "tfstatefile"
  }
  required_providers {
    google = {
        source = "hashicorp/google"
        version = "6.40.0"
    }
  }
}

provider "google" {
    project = var.project_id_1
    zone = var.zone
    region = var.region
    credentials = file(var.credentials_1)
}

module "bucket_creation" {
  count                = var.module_selector["bucket"].enable ? 1 : 0
  source               = "../modules/Buckets"
  project_id           = var.project_id_1
  zone                 = var.zone
  region               = var.region
  credentials          = var.credentials_1
  bucket               = var.module_selector["bucket"].instance
}

module "service_account_creation" {
  count        = var.module_selector["sa"].enable ? 1 : 0
  source       = "../modules/Service Account"
  project_id   = var.project_id_1
  zone         = var.zone
  region       = var.region
  credentials  = var.credentials_1
  sa           = var.module_selector["sa"].instance
}

module "vm_creation" {
  count        = var.module_selector["vm"].enable ? 1 : 0
  source       = "../modules/VM"
  project_id   = var.project_id_1
  zone         = var.zone
  region       = var.region
  credentials  = var.credentials_1
  vm           = var.module_selector["vm"].instance
  ssh-key      = "/home/atlantis/.atlantis/ssh_key.pub"
}

module "vpc_creation" {
  count        = var.module_selector["vpc"].enable ? 1 : 0
  source       = "../modules/VPC"
  project_id   = var.project_id_1
  zone         = var.zone
  region       = var.region
  credentials  = var.credentials_1
  vpc          = var.module_selector["vpc"].instance
}



# locals {
#   credentials = var.project_selector == "project1" ? var.credentials_1 : var.credentials_2
#   project_id = var.project_selector == "project1" ? var.project_id_1 : var.project_id_2
# }
 