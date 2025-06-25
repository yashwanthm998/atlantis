resource "google_storage_bucket" "bucket1" {
  name = "gcloud-bucket-using-tl123"
  location = var.bucket_zone_location
  storage_class = "STANDARD"
  
  lifecycle_rule {
    action {
      
      type = "SetStorageClass"
      storage_class = "REGIONAL"
    }
    condition {
      age = 15
      with_state = "ANY"
    }
  }
}

resource "google_storage_bucket_object" "object1" {
  bucket = google_storage_bucket.bucket1.name
  name = var.image_name
  source = var.image_source
}
