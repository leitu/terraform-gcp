#--------------------------------------------------------------
# This module creates all resources necessary for a firewall
#--------------------------------------------------------------

variable subnet_name {}
variable subnet_ip_cidr {}

resource "google_compute_firewall" "firewall-internal" {
  name    = "network-allow-internal"
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

  # Source Tags is related to filter
  #source_tags = ["test-asia-northeast1"]
  source_ranges = ["${var.subnet_ip_cidr}"]
}

resource "google_compute_firewall" "firewall-ssh" {
  name    = "network-allow-ssh"
  network = "${var.subnet_name}"

  # Priority will be add later
  # priority = "65534"

  allow {
    protocol = "tcp"
    ports = ["22"]
  }

  # Source Tags is related to filter
  # source_tags = ["IP ranges: 0.0.0.0/0"]
}