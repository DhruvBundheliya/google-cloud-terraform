variable "project_id" {
  description = "The ID of the project where this VPC will be created"
  type        = string
}

variable "project" {
  description = "Name of the Project"
  type        = string
}

variable "environment" {
  description = "The environment in which the resources are being created"
  type        = string
}

variable "region" {
  type        = string
  description = "Provide region in which subnet should be created"
}

variable "bucket_name" {
  type = list(string)
  description = "value of the bucket name"
}

variable "ip_address_name" {
  type = string
  description = "value of the ip address name"
}

variable "url_map_name" {
  type = string
  description = "value of the url map name"
}

variable "host_rule" {
  type = list(string)
  description = "value of the host rule"
  default = [ "example.com" ]
}

variable "path_matcher" {
  type = string
  description = "value of the path matcher"
  default = "/*"
}

variable "path_matcher_name" {
  type = string
  description = "value of the path matcher name"
}

variable "path_rule" {
  type = string
  description = "value of the backend service name"
}