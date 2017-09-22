output "vpc_name" {
  value = "${google_compute_network.network.name}"
}

output "vpc_self_link" {
  value = "${google_compute_network.network.self_link}"
}