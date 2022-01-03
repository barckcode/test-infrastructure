variable "tipo_instancia" {
  description = "Tipo de la instancia EC2"
  type        = string
  default     = "t2.micro"
}

variable "servidores" {
  description = "Mapa de servidores con su correspondiente subnet publica"

  type = map(object({
      nombre    = string
      subnet_id = string
      ami_id    = string
    })
  )
}
