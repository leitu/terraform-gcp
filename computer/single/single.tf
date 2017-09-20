#--------------------------------------------------------------
# This module creates all resources necessary for a Single Server
#--------------------------------------------------------------
variable name {}
variable type {}
variable zone {}
variable tag {}
variable subnetwork {}

resource "google_compute_instance" "default" {
  name         = "${var.name}"
  machine_type = "${var.type}"
  zone         = "${var.zone}"
  can_ip_forward = "${var.tag == "nat" ? true : false}"

  tags = ["${var.tag}"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-8"
    }
  }

  network_interface {
    access_config { }
    subnetwork = "${var.subnetwork}"
  }

}