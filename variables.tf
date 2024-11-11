variable "instance_type" {
  description = "Type of EC2 instance to provision"
  default     = "t3.nano"
}

variable "subnet" {
type        = string
 description = "Subnet ID for network interface"
 default     = "subnet-07acc523071905f13"
}

variable "vpc" {
type        = string
 description = "Subnet ID for network interface"
 default     = "subnet-07acc523071905f13"
}


