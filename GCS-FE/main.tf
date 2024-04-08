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

module "bucket" {
  source  = "terraform-google-modules/cloud-storage/google//modules/simple_bucket"
  version = "5.0.0"
  name       = var.bucket_name
  project_id = var.project_id
  location   = var.region
  website    = {
    main_page_suffix = "index.html"
    not_found_page   = "error.html"
  }
  public_access_prevention = "inherited"
  set_viewer_roles = true
  iam_members = [{
    role   = "roles/storage.objectViewer"
    member = "allUsers"
  }]
}

# Reserve IP address
resource "google_compute_global_address" "default" {
  name = var.ip_address_name
}
# Create url map
resource "google_compute_url_map" "default" {
  name = var.url_map_name
  default_service = module.bucket.id

  host_rule {
    hosts        = var.host_rule
    path_matcher = var.path_matcher
  }
  path_matcher {
    name            = var.path_matcher_name
    default_service = module.bucket.id

    path_rule {
      paths   = var.path_rule
      service = module.bucket.id
    }
  }
}

# Create HTTP target proxy
resource "google_compute_target_http_proxy" "default" {
  name    = var.http_proxy_name
  url_map = google_compute_url_map.default.id
}

# Create forwarding rule
resource "google_compute_global_forwarding_rule" "default" {
  name                  = var.forwarding_rule_name
  ip_protocol           = var.forwarding_rule_ip_protocol
  load_balancing_scheme = var.load_balancing_scheme
  port_range            = var.port_range
  target                = google_compute_target_http_proxy.default.id
  ip_address            = googport_rangeddress.default.id
}