#--------------------------------------------------------------
# This module creates all resources necessary for a Subnet
#--------------------------------------------------------------
variable name {}
variable region {}
variable ip_cidr_range {}
variable vpc_self_link {}

resource "google_compute_subnetwork" "subnet" {
  name          = "${var.name}"
  ip_cidr_range = "${var.ip_cidr_range}"
  network       = "${var.vpc_self_link}"
  region        = "${var.region}"
}

output "subnet_name" {
  value = "${google_compute_subnetwork.subnet.name}"
}

output "subnet_self_link" {
  value = "${google_compute_subnetwork.subnet.self_link}"
}
