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

variable "cluster_name" {
  description = "The name of the cluster."
  type        = string
}

variable "region" {
  type        = string
  description = "The region in which cluster will created."
}

variable "cluster_zones" {
  type        = list(string)
  description = "The zones in which cluster will create resources."
}

variable "vpc_name" {
  type        = string
  description = "The name of the vpc in which kubernetes cluster should be created."
}

variable "http_load_balancing" {
  type        = bool
  description = "This will loadbalance the request from the service to the pods on multiple nodes."
  default     = true
}

variable "subnetwork" {
  type        = string
  description = "The subnetwork in which the your cluster will be hosted."
}

variable "ip_range_pods" {
  type        = string
  description = "The CIDR range for pods."
}

variable "ip_range_services" {
  type        = string
  description = "The CIDR range for services."
}

variable "master_ipv4_cidr_block" {
  type        = string
  description = "The CIDR range of the control plane."
}

variable "maintenance_start_time" {
  type        = string
  description = "The time stamp when our maintenance will start in RFC3339 formate."
}

variable "maintenance_end_time" {
  type        = string
  description = "The time stamp when our maintenance will end in RFC3339 formate."
}

variable "maintenance_recurrence" {
  type        = string
  description = "The recurrence policy for the maintenance."
}

variable "node_pool_name" {
  type        = string
  description = "The name of the default node pool for the cluster."
}

variable "machine_type" {
  type        = string
  description = "The machine type you want to use for the node pool."
}

variable "node_locations" {
  type        = string
  description = "The location at which our nodes will be created."
}

variable "min_count" {
  type        = number
  description = "The minimum number of nodes."
  default     = 0
}

variable "max_count" {
  type        = number
  description = "The minimum number of nodes."
  default     = 0
}

variable "spot" {
  type        = bool
  description = "The node should be spot or not, If false then it will create the on-demand node."
  default     = false
}

variable "disk_size_gb" {
  type        = number
  description = "The size of boot disk of each node."
  default     = 20
}

variable "service_account" {
  type        = string
  description = "The service account that will be attached with the nodes in the nodegroup."
}

variable "initial_node_count" {
  type        = number
  description = "The total number of nodes in the nodegroup that will be created at the initial stage."
}

variable "node_pool_name_1" {
  type        = string
  description = "The name of the default node pool for the cluster."
}

variable "accelerator_count_1" {
  type        = number
  description = "The number of GPU you need."
}

variable "accelerator_type_1" {
  type        = string
  description = "The type of GPU."
}

variable "machine_type_1" {
  type        = string
  description = "The machine type you want to use for the node pool."
}

variable "node_locations_1" {
  type        = string
  description = "The location at which our nodes will be created."
}

variable "min_count_1" {
  type        = number
  description = "The minimum number of nodes."
  default     = 0
}

variable "max_count_1" {
  type        = number
  description = "The minimum number of nodes."
  default     = 0
}

variable "spot_1" {
  type        = bool
  description = "The node should be spot or not, If false then it will create the on-demand node."
  default     = false
}

variable "disk_size_gb_1" {
  type        = number
  description = "The size of boot disk of each node."
  default     = 20
}

variable "service_account_1" {
  type        = string
  description = "The service account that will be attached with the nodes in the nodegroup."
}

variable "initial_node_count_1" {
  type        = number
  description = "The total number of nodes in the nodegroup that will be created at the initial stage."
}

variable "master_authorized_networks" {
  type        = list(object({ cidr_block = string, display_name = string }))
  description = "List of master authorized networks. If none are provided, disallow external access (except the cluster node IPs, which GKE automatically whitelists)."
  default     = []
}

variable "release_channel" {
    type =  string
    description = "The release channel of the cluster."
    default = "stable"
}

variable "logging_service" {
  type = string
  description = "The logging service to use for the cluster."
  default = "none"
}

variable "monitoring_service" {
    type = string
    description = "The monitoring service to use for the cluster."
    default = "none"
}

variable "monitoring_enable_managed_prometheus" {
    type = bool
    description = "Whether or not to enable the managed Prometheus service."
    default = false
}