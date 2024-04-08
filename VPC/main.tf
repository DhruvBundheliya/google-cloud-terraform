terraform {
  backend "gcs" {
    prefix = "vpc/vpc.tfstate"
  }
}

locals {
  tf_backend_workspace = substr(terraform.workspace, 0, 4) == "prod" ? "prod" : substr(terraform.workspace, 0, 3) == "dev" ?  "dev" : "default"
  environment = var.environment == "auto" ? regex("^(dev|default|prod)-", terraform.workspace)[0] : var.environment
  default_tags = {
    "Environment" = "${local.environment}"
    "managed_by"  = "terraform"
    "Project_cost" = "${var.project}"
  }
}

/******************************************
	VPC configuration and subnet configuration
 *****************************************/
module "vpc" {
  source = "terraform-google-modules/network/google"
  version      = "9.0.0"
  network_name = var.network_name
  routing_mode = var.routing_mode
  project_id   = var.project_id
  description  = var.description
  mtu = var.mtu
  subnets = [
    {
      subnet_name           = var.public_subnet_1
      subnet_ip             = var.public_subnet_1_cidr
      subnet_region         = var.region
      subnet_private_access = "true"
      subnet_flow_logs      = "false"
    },
    {
      subnet_name           = var.public_subnet_2
      subnet_ip             = var.public_subnet_2_cidr
      subnet_region         = var.region
      subnet_private_access = "true"
      subnet_flow_logs      = "false"
    },
    {
      subnet_name           = var.private_subnet_1
      subnet_ip             = var.private_subnet_1_cidr
      subnet_region         = var.region
      subnet_private_access = "true"
      subnet_flow_logs      = "false"
    },
    {
      subnet_name           = var.private_subnet_2
      subnet_ip             = var.private_subnet_2_cidr
      subnet_region         = var.region
      subnet_private_access = "true"
      subnet_flow_logs      = "false"
    },
  ]

  secondary_ranges = {
    (var.private_subnet_1) = [
      {
        range_name    = var.private_secondery_range_pod_name
        ip_cidr_range = var.private_secondery_range_pod_cidr
      },
      {
        range_name    = var.private_secondery_range_service_name
        ip_cidr_range = var.private_secondery_range_service_cidr
      },
    ],
  }
}
/******************************************
	Cloud router and Cloud NAT
 *****************************************/
module "cloud_router" {
  source = "terraform-google-modules/cloud-router/google"
  version = "6.0.2"
  name    = var.cloud-router-name
  project = var.project_id
  region  = var.region
  network = var.network_name
}

module "cloud-nat" {
  name   = var.cloud-nat-name
  source = "terraform-google-modules/cloud-nat/google"
  version    = "5.0.0"
  project_id = var.project_id
  region     = var.region
  router     = var.cloud-router-name
  depends_on = [module.cloud_router, module.vpc]
}