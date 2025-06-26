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

variable "sa" {
  type = object({
    account_id = string
    display_name = string
  })
}