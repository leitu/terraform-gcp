#--------------------------------------------------------------
# This module creates all resources necessary for a VNET
#--------------------------------------------------------------

resource "google_compute_network" "network" {
  name = "${var.name}"
}