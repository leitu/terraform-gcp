#--------------------------------------------------------------
# This module creates all networking resources
#--------------------------------------------------------------
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
    region = "${var.region}"
    subnet_name = "${module.vpc.vpc_name}"
    subnet_ip_cidr = "${var.ip_cidr_range}"
}


