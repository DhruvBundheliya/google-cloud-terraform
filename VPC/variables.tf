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

variable "network_name" {
  description = "The name of the network being created"
  type        = string
}

variable "routing_mode" {
  type        = string
  default     = "GLOBAL"
  description = "The network routing mode (default 'GLOBAL')"
}

variable "description" {
  type        = string
  description = "An optional description of this resource. The resource must be recreated to modify this field."
  default     = ""
}

variable "mtu" {
  type        = number
  description = "The network MTU (If set to 0, meaning MTU is unset - defaults to '1460'). Recommended values: 1460 (default for historic reasons), 1500 (Internet default), or 8896 (for Jumbo packets). Allowed are all values in the range 1300 to 8896, inclusively."
  default     = 0
}

variable "public_subnet_1" {
  type        = string
  description = "This is the name of subnet-1"
}

variable "public_subnet_2" {
  type        = string
  description = "This is the name of subnet-2"
}

variable "private_subnet_1" {
  type        = string
  description = "This is the name of subnet-3"
}

variable "private_subnet_2" {
  type        = string
  description = "This is the name of subnet-4"
}

variable "public_subnet_1_cidr" {
  type        = string
  description = "Provide cidr range for subnet-1"
}

variable "public_subnet_2_cidr" {
  type        = string
  description = "Provide cidr range for subnet-2"
}

variable "private_subnet_1_cidr" {
  type        = string
  description = "Provide cidr range for subnet-3"
}

variable "private_subnet_2_cidr" {
  type        = string
  description = "Provide cidr range for subnet-4"
}

variable "region" {
  type        = string
  description = "Provide region in which subnet should be created"
}

variable "private_secondery_range_pod_name" {
  type        = string
  description = "The name of the cidr range that will be created as a secondary range in web private subnet, which will be used as pod range in kubernetes cluster."
}

variable "private_secondery_range_pod_cidr" {
  type        = string
  description = "The cidr range for pod in kubernetes cluster."
}

variable "private_secondery_range_service_name" {
  type        = string
  description = "The name of the cidr range that will be created as a secondary range in web private subnet, which will be used as service range in kubernetes cluster."
}

variable "private_secondery_range_service_cidr" {
  type        = string
  description = "The cidr range for service in kubernetes cluster."
}

variable "cloud-router-name" {
  type        = string
  description = "Name of router"
}

variable "cloud-nat-name" {
  type        = string
  description = "Name of NAT"
}

variable "admin_network_name" {
  type        = string
  description = "The name of the admin VPC."
}