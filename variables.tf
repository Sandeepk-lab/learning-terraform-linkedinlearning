variable "instance_type" {
  description = "Type of EC2 instance to provision"
  default     = "t3.nano"
}

variable "subnet_id" {}

variable "vpc_id" {}
