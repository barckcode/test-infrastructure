# EC2 Instance
variable "instances" {
  description = "Mapa de servidores"

  type = map(object({
      name          = string
      ami_id        = string
      instance_type = string
      private_ip    = string
      disk_size     = number
      subnet_id     = string
      creation      = string
    })
  )
}


# Elastic IP
variable "depends_on_eip" {
  description = "Internet GW"
  type        = any
}