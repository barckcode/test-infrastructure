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
