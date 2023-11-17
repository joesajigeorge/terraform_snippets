variable "availabilityzones" {
    type = list(string)
    default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "subnets" {
    default = {
        us-east-1a = {
            us-east-1a-subnet1-public = "192.168.0.0/24"
            us-east-1a-subnet2-public = "192.168.1.0/24"
            us-east-1a-subnet1-private = "192.168.2.0/24"
        }
        us-east-1b = {
            us-east-1b-subnet1-public = "192.168.3.0/24"
            us-east-1b-subnet1-private = "192.168.4.0/24"
        }
        us-east-1c = {
            us-east-1c-subnet1-public = "192.168.5.0/24"
            us-east-1c-subnet2-public = "192.168.6.0/24"
            us-east-1c-subnet1-private = "192.168.7.0/24"
            us-east-1c-subnet2-private = "192.168.8.0/24"
        }
    }
}

locals {
    subet-map = flatten([
        for zone in var.availabilityzones : [
            for subnet, cidr in var.subnets[zone] : {
                    "az-zone" = zone
                    "subnet" = subnet
                    "cidr" = cidr
            }
        ]
    ])
}

output "subet-map" {
  value = local.subet-map
}
