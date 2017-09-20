#--------------------------------------------------------------
# This module creates all resources necessary for a VNET
#--------------------------------------------------------------

variable "name" {
  default = "vnet"
}

resource "google_compute_network" "network" {
  name                    = "${var.name}"
}

output "vpc_name" {
  value = "${google_compute_network.network.name}"
}

output "vpc_self_link" {
  value = "${google_compute_network.network.self_link}"
}