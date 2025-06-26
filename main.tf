
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
  count                = var.module_selector["bucket"].enable ? 1 : 0
  source               = "./modules/Buckets"
  project_id           = local.project_id
  zone                 = var.zone
  region               = var.region
  credentials          = local.credentials
  bucket               = var.module_selector["bucket"].instance
}

module "service_account_creation" {
  count        = var.module_selector["sa"].enable ? 1 : 0
  source       = "./modules/Service Account"
  project_id   = local.project_id
  zone         = var.zone
  region       = var.region
  credentials  = local.credentials
  sa           = var.module_selector["sa"].instance
}

module "vm_creation" {
  count        = var.module_selector["vm"].enable ? 1 : 0
  source       = "./modules/VM"
  project_id   = local.project_id
  zone         = var.zone
  region       = var.region
  credentials  = local.credentials
  vm           = var.module_selector["vm"].instance
}

module "vpc_creation" {
  count        = var.module_selector["vpc"].enable ? 1 : 0
  source       = "./modules/VPC"
  project_id   = local.project_id
  zone         = var.zone
  region       = var.region
  credentials  = local.credentials
  vpc          = var.module_selector["vpc"].instance
}



locals {
  credentials = var.project_selector == "project1" ? var.credentials_1 : var.credentials_2
  project_id = var.project_selector == "project1" ? var.project_id_1 : var.project_id_2
}
 