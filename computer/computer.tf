#--------------------------------------------------------------
# This module creates all computer resources
#--------------------------------------------------------------
#variable name {}
variable type { default = "n1-standard-1" }
variable zone {}
#variable tag {}
variable subnetwork {}

module "nat" {
    source = "./nat-gateway"

    name = "nat-gateway"
    type = "${var.type}"
    zone = "${var.zone}"
    #network = "${var.network}"
    subnetwork = "${var.subnetwork}"
    tag = "nat"
}

module "shared" {
    source = "./single_no_external"

    name = "test-server"
    type = "${var.type}"
    zone = "${var.zone}"
    subnetwork = "${var.subnetwork}"
    # The tag means network tag or the others was label
    tag = "nat-route"
}

output "nat_name" {
    value = "${module.nat.nat_name}"
}
