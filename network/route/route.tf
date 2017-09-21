#--------------------------------------------------------------
# This module creates all resources necessary for a router
# This router will router all the traffic to nat server
#--------------------------------------------------------------


variable route_name { default = "nat-route" }
variable vpc_network {}
#variable nat_ip { default = "10.240.0.2" }
variable tag { default = "nat-route" }
variable nat_server_name {}
variable nat_server_zone {}

resource "google_compute_route" "default" {
  name        = "${var.route_name}"
  dest_range  = "0.0.0.0/0"
  network     = "${var.vpc_network}"
  #next_hop_ip = "10.240.0.2"
  next_hop_instance = "${var.nat_server_name}"
  next_hop_instance_zone = "${var.nat_server_zone}"
  priority    = 800
  tags        = ["${var.tag}"]
}