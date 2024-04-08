output "network_name" {
  value       = module.vpc.network_name
  description = "The name of the VPC being created"
}

output "network_id" {
  value       = module.vpc.network_id
  description = "The ID of the VPC being created"
}

output "project_id" {
  value       = module.vpc.project_id
  description = "VPC project id"
}

output "subnets_names" {
  value       = [for network in module.vpc.subnets : network.name]
  description = "The names of the subnets being created"
}

output "subnets_ids" {
  value       = [for network in module.vpc.subnets : network.id]
  description = "The IDs of the subnets being created"
}

output "subnets_ips" {
  value       = [for network in module.vpc.subnets : network.ip_cidr_range]
  description = "The IPs and CIDRs of the subnets being created"
}

output "subnets_secondary_ranges" {
  value       = [for network in module.vpc.subnets : network.secondary_ip_range]
  description = "The secondary ranges associated with these subnets"
}