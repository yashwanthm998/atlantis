# variable "project_id_1" {
#     description = "Your project id"
#     type = string
# }

variable "project_id_2" {
    description = "Your project id"
    type = string
}

# variable "project_selector" {
#   type = string
# }

variable "zone" {
  description = "Instance zone"
  type = string
}

variable "region" {
  description = "Instance region"
  type = string
}

# variable "credentials_1" {
#   type = string
# }

variable "credentials_2" {
  type = string
}

variable "module_selector" {
  type = any
}
