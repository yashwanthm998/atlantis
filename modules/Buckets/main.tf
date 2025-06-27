resource "google_storage_bucket" "bucket1" {
  for_each = {for buk in var.bucket : buk.bucket_name => buk}
  name = each.value.bucket_name
  location = each.value.bucket_zone_location
  storage_class = each.value.storage_class
  
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
  bucket = google_storage_bucket.bucket1[each.key].name
  name = each.value.image_name
  source = each.value.image_source
}
