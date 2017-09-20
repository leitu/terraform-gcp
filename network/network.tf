#--------------------------------------------------------------
# This module creates all networking resources
#--------------------------------------------------------------

variable "vpc_name" {}
variable "subnet_name" {}
variable "region" {}
variable "ip_cidr_range" {}

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

module "firewall" {
    source = "./firewall"
    subnet_name = "${module.vpc.vpc_name}"
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