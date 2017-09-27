data "template_file" "nat-startup-script" {
  template = <<EOF
#!/bin/bash -xe
# Enable ip forwarding and nat
sysctl -w net.ipv4.ip_forward=1
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
EOF
}

module "nat-gateway" {
  source            = "./instance-group"
  region            = "${var.region}"
  zone              = "${var.zone == "" ? lookup(var.region_params["${var.region}"], "zone") : var.zone}"
  network           = "${var.network}"
  subnetwork        = "${var.subnetwork}"
  machine_type      = "${var.machine_type}"
  name              = "nat-gateway-${var.region}"
  compute_image     = "debian-cloud/debian-8"
  size              = 1
  network_ip        = "${var.ip == "" ? lookup(var.region_params["${var.region}"], "ip") : var.ip}"
  can_ip_forward    = "true"
  startup_script    = "${data.template_file.nat-startup-script.rendered}"

  access_config = [{
    nat_ip = "${google_compute_address.default.address}"
  }]
}

resource "google_compute_route" "nat-gateway" {
  name        = "nat-${var.region}"
  dest_range  = "0.0.0.0/0"
  network     = "${var.network}"
  next_hop_ip = "${var.ip == "" ? lookup(var.region_params["${var.region}"], "ip") : var.ip}"
  tags        = "${compact(concat(list("nat-${var.region}"), var.tags))}"
  priority    = "${var.route_priority}"
  depends_on  = ["module.nat-gateway"]
}

resource "google_compute_address" "default" {
  name = "nat-${var.region}"
}


module "test-server" {
  source            = "./instance-group"
  region            = "${var.region}"
  zone              = "${var.zone == "" ? lookup(var.region_params["${var.region}"], "zone") : var.zone}"
  network           = "${var.network}"
  subnetwork        = "${var.subnetwork}"
  machine_type      = "${var.machine_type}"
  name              = "test-${var.region}"
  compute_image     = "debian-cloud/debian-8"
  size              = 1
  #network_ip        = "${var.ip == "" ? lookup(var.region_params["${var.region}"], "ip") : var.ip}"
  #network_ip         = "10.240.0.3"
  network_ip         = "${cidrhost("${var.ip_cidr_range}", 3)}"
  #can_ip_forward    = "true"
  #startup_script    = "${data.template_file.nat-startup-script.rendered}"
  access_config     = []
  target_tags        = ["nat-${var.region}","allow-service"]
}


resource "null_resource" "something" {
  depends_on = ["module.test-server"]
 provisioner "remote-exec" {
  connection {
    bastion_host = "${google_compute_address.default.address}"
    bastion_user = "testuser"
    bastion_private_key = "${file("xyz.pem")}"
    host = "${cidrhost("${var.ip_cidr_range}", 3)}"
    user = "alex.lei.tu"
    private_key = "${file("xyz.pem")}"

  }
  inline = [
    "echo hello"
  ]
}
}