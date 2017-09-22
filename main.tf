#--------------------------------------------------------------
# This is the main file
#--------------------------------------------------------------
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
}

module "computer" {
  source = "./computer"
  network = "${var.vpc_name}"
  region = "${var.region}"
  subnetwork = "${module.network.subnet_name}"
}