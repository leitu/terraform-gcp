#--------------------------------------------------------------
# This module creates all resources necessary for a Single Server
#--------------------------------------------------------------
variable name {}
variable type {}
variable zone {}
variable subnetwork {}
variable tag {}

resource "google_compute_instance" "default" {
  name         = "${var.name}"
  machine_type = "${var.type}"
  zone         = "${var.zone}"

  tags = ["${var.tag}"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-8"
    }
  }

  network_interface {
    subnetwork = "${var.subnetwork}"
  }

}