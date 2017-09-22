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
