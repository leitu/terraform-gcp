variable "vpc_name" {
  default = "gpp"
}

variable "subnet_name" {
  default = "gpp-subnet"
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
