resource "google_storage_bucket" "bucket1" {
  name = "gcloud-bucket-using-atlantis"
  location = "asia-southeast1"
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
  retention_policy {
     is_locked = true
     retention_period = 432000
   }
}

resource "google_storage_bucket_object" "object1" {
  bucket = google_storage_bucket.bucket1.name
  name = "sample_image"
  source = "image1.png"
}