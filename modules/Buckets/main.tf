resource "google_storage_bucket" "bucket1" {
  for_each = {for buk in var.bucket : buk.bucket_name => buk}
  name = var.bucket.bucket_name
  location = var.bucket.bucket_zone_location
  storage_class = var.bucket.storage_class
  
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
  for_each = {for buk in var.bucket : buk.bucket_name => buk}
  bucket = google_storage_bucket.bucket1.name
  name = var.bucket.image_name
  source = var.bucket.image_source
}
