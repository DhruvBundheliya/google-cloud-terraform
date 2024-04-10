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