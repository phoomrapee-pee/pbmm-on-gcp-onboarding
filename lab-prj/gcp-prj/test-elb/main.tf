# resource "google_compute_backend_service" "api" {
#   provider =  google.gcp-techx
#   project = "scbtechx-sharedvpc-nonprod"

#   name        = "test-tf-api"
#   description = "API Backend for test-tf"
#   port_name   = "http"
#   protocol    = "HTTP"
#   timeout_sec = 10
#   enable_cdn  = false

#   backend {
#     # group = google_compute_network_endpoint_group.api.self_link
#     group = google_compute_instance_group.api.self_link
#   }

#   health_checks = [google_compute_health_check.default.self_link]

#   # depends_on = [google_compute_network_endpoint_group.api]
#   depends_on = [google_compute_instance_group.api]
# }

# ------------------------------------------------------------------------------
# CONFIGURE HEALTH CHECK FOR THE API BACKEND
# ------------------------------------------------------------------------------

resource "google_compute_health_check" "default" {
  provider =  google.gcp-techx
  # project = var.project
  project = "scbtechx-sharedvpc-nonprod"
  name    = "test-tf-hc"

  http_health_check {
    port         = 80
    request_path = "/"
  }

  check_interval_sec = 5
  timeout_sec        = 5
}

# resource "google_compute_network_endpoint_group" "api" {
#   provider =  google.gcp-pex
#   project      = "pex-nonprod"
#   name         = "my-lb-neg"
#   network      = "projects/pex-nonprod/global/networks/pex-nonprod-vpc1"
#   subnetwork   = "projects/pex-nonprod/regions/asia-southeast1/subnetworks/subnet-pex-nonprod1"
#   default_port = "80"
#   zone         = "asia-southeast1-b"
# }
# ------------------------------------------------------------------------------
# projects/{{project}}/zones/{{zone}}/networkEndpointGroups/{{name}}
# resource "google_compute_network_endpoint_group" "neg" {
#   name         = "my-lb-neg"
#   network      = google_compute_network.default.id
#   subnetwork   = google_compute_subnetwork.default.id
#   default_port = "90"
#   zone         = "us-central1-a"
# }
# ------------------------------------------------------------------------------

resource "google_compute_instance_group" "api" {
  provider =  google.gcp-pex
  project      = "pex-nonprod"
  name      = "test-tf-instance-group"
  zone      = "asia-southeast1-b"
  instances = [google_compute_instance.api.self_link]

  lifecycle {
    create_before_destroy = true
  }

  named_port {
    name = "http"
    port = 5000
  }
}

resource "google_compute_instance" "api" {
  provider =  google.gcp-pex
  project      = "pex-nonprod"
  name         = "test-tf-instance"
  machine_type = "f1-micro"
  zone      = "asia-southeast1-b"

  # We're tagging the instance with the tag specified in the firewall rule
  tags = ["private-app"]

  boot_disk {
    initialize_params {
      image = "debian-11-bullseye-v20220719"
    }
  }

  # Make sure we have the flask application running
  # metadata_startup_script = file("${path.module}/examples/shared/startup_script.sh")

  # Launch the instance in the default subnetwork
  network_interface {
    subnetwork = "projects/pex-nonprod/regions/asia-southeast1/subnetworks/subnet-pex-nonprod1"

    # This gives the instance a public IP address for internet connectivity. Normally, you would have a Cloud NAT,
    # but for the sake of simplicity, we're assigning a public IP to get internet connectivity
    # to be able to run startup scripts
    access_config {
    }
  }
}