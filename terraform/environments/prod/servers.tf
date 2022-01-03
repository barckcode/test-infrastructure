# variable "servers" {
#   description = "Servers Map"
#   type = map(object({
#       ami_id = string,
#       custom_private_ip = string,
#       disk_size = number,
#       instance_type = string,
#       name = string,
#     })
#   )

#   default = {
#     "bbdd01" = {
#       ami_id = "ami-08f173bf94c7ac0a5"
#       custom_private_ip = "10.0.1.111"
#       disk_size = 30
#       instance_type = "t3.micro"
#       name = "bbdd01"
#     },
#     "sauron" = {
#       ami_id = "ami-08f173bf94c7ac0a5"
#       custom_private_ip = "10.0.1.11"
#       disk_size = 30
#       instance_type = "t3.micro"
#       name = "sauron"
#     }
#   }
# }


# module "ec2_instances" {
#   for_each = var.servers

#   # EC2 Instance
#   source = "../../modules/ec2_instances"
#   ami_id = each.value.ami_id
#   instance_type = each.value.instance_type
#   subnet_id = aws_subnet.main_subnet_01.id
#   custom_private_ip = each.value.custom_private_ip
#   disk_size = each.value.disk_size
#   tags_group = {
#     name = each.value.name
#     creation = local.terraform_tag
#   }

#   # Elastic IP
#   #id_instance_eip = for [module.ec2_instances.instances_ids
#   #depends_on_eip = aws_internet_gateway.main_internet_gw
# }

variable "servidores" {
  description = "Mapa de servidores con su correspondiente AZ"

  type = map(object({
      nombre = string
      az     = string
      ami_id = string
    })
  )

  default = {
    "sauron" = {
      nombre = "sauron"
      az = "a"
      ami_id = "ami-08f173bf94c7ac0a5"
    },
    "bbdd01" = {
      nombre = "bbdd01"
      az = "b"
      ami_id = "ami-08f173bf94c7ac0a5"
    },
  }
}

module "servidores_ec2" {
  source = "../../modules/ec2_instances"

  tipo_instancia = "t2.micro"

  servidores = {
    for id_ser, datos in var.servidores :
    id_ser => {
      nombre = datos.nombre
      subnet_id = aws_subnet.main_subnet_01.id
      ami_id = datos.ami_id
    }
  }
}
