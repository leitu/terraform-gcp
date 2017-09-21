#--------------------------------------------------------------
# This is the main file
#--------------------------------------------------------------
variable "vpc_name" {
  default = "test"
}

variable "subnet_name" {
  default = "test-asia-northeast1"
}

variable "region" {
  default = "asia-northeast1"
}

variable "zone" {
  default = "asia-northeast1-a"
}

variable "ip_cidr_range" {
  default = "10.240.0.0/16"
}

provider "google" {
  credentials = "${file(".account.json")}"
  project     = "global-payment"
  region      = "${var.region}"
}

# Network
module "network" {
  source = "./network"
  vpc_name = "${var.vpc_name}"
  subnet_name = "${var.subnet_name}"
  ip_cidr_range = "${var.ip_cidr_range}"
  region = "${var.region}"
  zone = "${var.zone}"
  nat_name = "${module.computer.nat_name}"
}

# Computer
module "computer" {
  source = "./computer"

  zone = "${var.zone}"
  subnetwork = "${module.network.subnet_name}"

}

# Output
output "vpc_name" {
  value = "${module.network.vpc_name}"
}
output "vpc_self_link" {
  value = "${module.network.vpc_self_link}"
}
output "subnet_name" {
  value = "${module.network.subnet_name}"
}
output "subnet_self_link" {
  value = "${module.network.subnet_self_link}"
}

output "nat_name" {
    value = "${module.computer.nat_name}"
}
