variable "ami_id" {
  description = "AMI ID"
  type        = string
}

variable "instance_type" {
  description = "Instance type"
  type = string
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}

variable "custom_private_ip" {
  description = "Custom Private IP"
  type        = string
}

variable "disk_size" {
  description = "Disk Size"
  type        = number
}

variable "tags_group" {
  description = "Tags Group"
  type = map(string)
}
