#--------------------------------------------------------------
# This module creates all computer resources
#--------------------------------------------------------------
#variable name {}
variable type { default = "n1-standard-1" }
variable zone {}
#variable tag {}
variable subnetwork {}

module "nat" {
    source = "./single"

    name = "nat-server"
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
    tag = "test"
}

