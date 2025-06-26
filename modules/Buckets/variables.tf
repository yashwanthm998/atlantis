variable "project_id" {
    description = "Your project id"
    type = string
}

variable "zone" {
  description = "Instance zone"
  type = string
}

variable "region" {
  description = "Instance region"
  type = string
}

variable "credentials" {
  description = "Path to your key.json"
  type = string
}


variable "bucket" {
  type = object({
    bucket_name = string
    bucket_zone_location = string
    storage_class = string
    image_name = string
    image_source = string 
  })
  
}