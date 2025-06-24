terraform {
  required_providers {
    google = {
        source = "hashicorp/google"
        version = "6.40.0"
    }
  }
}

provider "google" {
    project = "terraform-gcp-463406"
    zone = "asia-southeast1-a"
    region = "asia-southeast1"
    credentials = file("/home/atlantis/.atlantis/repos/yashwanthm998/atlantis/creds.json")
}