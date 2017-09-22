#--------------------------------------------------------------
# This module creates all resources necessary for a Subnet
#--------------------------------------------------------------

resource "google_compute_subnetwork" "subnet" {
  name          = "${var.name}"
  ip_cidr_range = "${var.ip_cidr_range}"
  network       = "${var.vpc_self_link}"
  region        = "${var.region}"
}


