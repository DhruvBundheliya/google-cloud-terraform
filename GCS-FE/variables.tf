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

variable "http_proxy_name" {
  type = string
  description = "value of the http proxy name"
}

variable "forwarding_rule_name" {
  type = string
  description = "value of the forwarding rule name"
}

variable "forwarding_rule_ip_protocol" {
  type = string
  description = "value of the forwarding rule ip protocol"
}

variable "load_balancing_scheme" {
  type = string
  description = "value of the load balancing scheme"
  default = "EXTERNAL"
}

variable "port_range" {
  type = string
  description = "value of the port range"
  default = "80"
}

variable "paths" {
  type = list(string)
  description = "value of the path"
}