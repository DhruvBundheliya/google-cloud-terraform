terraform {
  backend "gcs" {
    prefix = "gke/gke.tfstate"
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
	Google Kubernetes configuration
 *****************************************/
data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

module "gke" {
  source                               = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  version                              = "30.2.0"
  project_id                           = var.project_id
  name                                 = var.cluster_name
  region                               = var.region
  release_channel                      = var.release_channel
  zones                                = var.cluster_zones
  network                              = var.vpc_name
  http_load_balancing                  = var.http_load_balancing
  network_policy                       = false
  horizontal_pod_autoscaling           = true
  filestore_csi_driver                 = true
  subnetwork                           = var.subnetwork
  ip_range_pods                        = var.ip_range_pods
  ip_range_services                    = var.ip_range_services
  enable_private_endpoint              = true
  enable_private_nodes                 = true
  master_ipv4_cidr_block               = var.master_ipv4_cidr_block
  remove_default_node_pool             = true
  logging_service                      = var.logging_service
  monitoring_service                   = var.monitoring_service
  enable_cost_allocation               = true
  maintenance_start_time               = var.maintenance_start_time
  maintenance_end_time                 = var.maintenance_end_time
  maintenance_recurrence               = var.maintenance_recurrence
  monitoring_enable_managed_prometheus = var.monitoring_enable_managed_prometheus

  node_pools = [
    {
      name               = var.node_pool_name
      machine_type       = var.machine_type
      node_locations     = var.node_locations
      min_count          = var.min_count
      max_count          = var.max_count
      local_ssd_count    = 0
      spot               = var.spot
      disk_size_gb       = var.disk_size_gb
      disk_type          = "pd-standard"
      image_type         = "COS_CONTAINERD"
      enable_gcfs        = false
      enable_gvnic       = false
      auto_repair        = true
      auto_upgrade       = false
      service_account    = var.service_account
      preemptible        = false
      initial_node_count = var.initial_node_count
    },
    {
      name               = var.node_pool_name_1
      accelerator_count  = var.accelerator_count_1
      accelerator_type   = var.accelerator_type_1
      machine_type       = var.machine_type_1
      node_locations     = var.node_locations_1
      min_count          = var.min_count_1
      max_count          = var.max_count_1
      local_ssd_count    = 0
      spot               = var.spot_1
      disk_size_gb       = var.disk_size_gb_1
      disk_type          = "pd-standard"
      image_type         = "COS_CONTAINERD"
      enable_gcfs        = false
      enable_gvnic       = false
      auto_repair        = true
      auto_upgrade       = false
      service_account    = var.service_account_1
      preemptible        = false
      initial_node_count = var.initial_node_count_1
    },
  ]

  master_authorized_networks = var.master_authorized_networks

  node_pools_labels = {
    all = {},
    "${var.node_pool_name}" : {
      Name = var.node_pool_name
    },
    "${var.node_pool_name_1}" : {
      Name = var.node_pool_name_1
    }
  }
  node_pools_metadata = {
    all = {},
    "${var.node_pool_name}" : {
      Name = var.node_pool_name
    },
    "${var.node_pool_name_1}" : {
      Name = var.node_pool_name_1
    }
  }
  node_pools_tags = {
    all = [],

    "${var.node_pool_name}" = [
      var.node_pool_name
    ],
    "${var.node_pool_name_1}" = [
      var.node_pool_name_1
    ]
  }
}