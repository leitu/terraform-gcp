variable network {
  description = "The network to deploy to"
  default     = "default"
}

variable subnetwork {
  description = "The subnetwork to deploy to"
  default     = "default"
}

variable region {
  description = "The region to create the nat gateway instance in."
}

variable zone {
  description = "Override the zone used in the `region_params` map for the region."
  default     = ""
}

variable tags {
  description = "Additional compute instance network tags to apply route to."
  type        = "list"
  default     = []
}

variable route_priority {
  description = "The priority for the Compute Engine Route"
  default = 800
}

variable machine_type {
  description = "The machine type for the NAT gateway instance"
  default     = "n1-standard-1"
}

variable ip {
  description = "Override the IP used in the `region_params` map for the region."
  default     = ""
}

variable squid_enabled {
  description = "Enable squid3 proxy on port 3128."
  default     = "false"
}

variable squid_config {
  description = "The squid config file to use. If not specifed the module file config/squid.conf will be used."
  default     = ""
}

variable region_params {
  description = "Map of default zones and IPs for each region. Can be overridden using the `zone` and `ip` variables."
  type        = "map"

  default = {
    us-west1 {
      zone = "us-west1-b"
      ip   = "10.138.1.1"
    }

    us-central1 {
      zone = "us-central1-f"
      ip   = "10.128.1.1"
    }

    us-east1 {
      zone = "us-east1-b"
      ip   = "10.142.1.1"
    }

    us-east4 {
      zone = "us-east4-b"
      ip   = "10.150.1.1"
    }

    europe-west1 {
      zone = "europe-west1-b"
      ip   = "10.132.1.1"
    }

    europe-west2 {
      zone = "europe-west2-b"
      ip   = "10.154.1.1"
    }

    europe-west3 {
      zone = "europe-west3-b"
      ip   = "10.156.1.1"
    }

    asia-southeast1 {
      zone = "asia-southeast1-b"
      ip   = "10.148.1.1"
    }

    asia-east1 {
      zone = "asia-east1-b"
      ip   = "10.142.1.1"
    }

    asia-northeast1 {
      zone = "asia-northeast1-a"
      ip   = "10.240.0.2"
    }

    austrailia-southeast1 {
      zone = "austrailia-southeast1-b"
      ip   = "10.152.1.1"
    }
  }
}