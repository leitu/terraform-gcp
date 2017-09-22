#--------------------------------------------------------------
# This module creates all resources necessary for a firewall
#--------------------------------------------------------------

resource "google_compute_firewall" "firewall-internal" {
  name    = "${var.subnet_name}-allow-internal"
  network = "${var.subnet_name}"

  # Priority will be add later
  # priority = "65534"

  allow {
    protocol = "icmp"
  }

  allow {
      protocol = "tcp"
      ports = ["1-65535"]
  }

  allow {
      protocol = "udp"
      ports = ["1-65535"]
  }

  source_ranges = ["${var.subnet_ip_cidr}"]
  target_tags   = ["allow-internal"]
}

resource "google_compute_firewall" "firewall-ssh" {
  name    = "${var.subnet_name}-allow-ssh"
  network = "${var.subnet_name}"

  # Priority will be add later
  # priority = "65534"

  allow {
    protocol = "tcp"
    ports = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["allow-ssh"]

}
