
module "bucket_creation" {
  source = "../modules/Buckets"
  project_id = var.project_id
  zone = var.zone
  region = var.region
  credentials = var.credentials
  
  bucket_zone_location = var.bucket_zone_location
  image_name = var.image_name
  image_source = var.image_source
}