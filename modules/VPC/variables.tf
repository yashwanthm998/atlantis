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

variable "vpc" {
  type = object({
    network_name = string
    subnet_name = string
    ip = string
    firewall_name = string
  })

}
