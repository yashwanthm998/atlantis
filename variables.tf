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

variable "bucket_zone_location" {
  description = "Bucket Location"
  type = string
}

variable "image_name" {
  description = "Your image name"
  type = string
}

variable "image_source" {
  description = "Source to you image"
  type = string
}