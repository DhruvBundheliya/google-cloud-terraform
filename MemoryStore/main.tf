terraform {
  backend "gcs" {
    prefix = "gcs/gcs.tfstate"
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

module "memcache" {
  source  = "terraform-google-modules/memorystore/google//modules/memcache"
  version = "~> 8.0"

  name               = var.memorystore_name
  project            = var.project_id
  memory_size_mb     = var.memory_size_gb
  enable_apis        = var.enable_apis
  cpu_count          = var._cpu_count
  region             = var.region
  auth_enabled       = var.auth_enabled
  transit_encryption_mode = "SERVER_AUTHENTICATION"
  authorized_network = var.authorized_network
  maintenance_policy = {
    day      = var.maintenance_day
    duration = var.maintenance_duration
    start_time = {
      hours   = var.maintenance_hours
      minutes = var.maintenance_minutes
      seconds = var.maintenance_seconds
      nanos   = var.maintenance_nanos
    }
  }
}