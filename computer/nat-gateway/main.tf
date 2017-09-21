#--------------------------------------------------------------
# This module creates all resources necessary for a Single Server
#--------------------------------------------------------------
variable name {}
variable type {}
variable zone {}
variable tag {}
variable subnetwork {}

data "template_file" "nat-startup-script" {
  template = <<EOF
#!/bin/bash -xe
# Enable ip forwarding and nat
sysctl -w net.ipv4.ip_forward=1
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

EOF
}

resource "google_compute_instance" "default" {
  name         = "${var.name}"
  machine_type = "${var.type}"
  zone         = "${var.zone}"
  can_ip_forward = true

  tags = ["${var.tag}-gateway"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-8"
    }
  }

  network_interface {
    access_config { }
    subnetwork = "${var.subnetwork}"
  }

  metadata = "${map("startup-script", "${data.template_file.nat-startup-script.rendered}")}"

}

output "nat_name" {
    value = "${google_compute_instance.default.name}"
}