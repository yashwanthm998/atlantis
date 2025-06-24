
module "bucket_creation" {
  source               = "./modules/Buckets"
  project_id           = var.project_id
  zone                 = var.zone
  region               = var.region
  credentials          = file("/home/atlantis/.atlantis/repos/yashwanthm998/atlantis/creds.json")
  bucket_zone_location = var.bucket_zone_location
  image_name           = var.image_name
  image_source         = var.image_source
}
