#--------------------------------------------------------------
# This module creates all networking resources
#--------------------------------------------------------------

variable "vpc_name" {}
variable "subnet_name" {}
variable "region" {}
variable "ip_cidr_range" {}
variable "zone" {}
variable "nat_name" {}

# Create Vnet
module "vpc" {
    source = "./vpc"
    
    name = "${var.vpc_name}"
}

# Create Subnet
module "subnet" {
    source = "./subnet"

    name = "${var.subnet_name}"
    region = "${var.region}"
    ip_cidr_range = "${var.ip_cidr_range}"
    vpc_self_link = "${module.vpc.vpc_self_link}"

}

# Create firewall
module "firewall" {
    source = "./firewall"
    subnet_name = "${module.vpc.vpc_name}"
    subnet_ip_cidr = "${var.ip_cidr_range}"
}

# Create route
module "route" {
    source = "./route"
    vpc_network = "${module.vpc.vpc_name}"
    #nat_server_name = "nat-gateway"
    nat_server_name = "${var.nat_name}"
    nat_server_zone = "${var.zone}"
}

output "vpc_name" {
  value = "${module.vpc.vpc_name}"
}
output "vpc_self_link" {
    value = "${module.vpc.vpc_self_link}"
}

output "subnet_name" {
  value = "${module.subnet.subnet_name}"
}
output "subnet_self_link" {
    value = "${module.subnet.subnet_self_link}"
}