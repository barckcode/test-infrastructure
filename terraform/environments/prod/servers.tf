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

variable "instances" {
  description = "Mapa de servidores"

  type = map(object({
      name          = string
      ami_id        = string
      instance_type = string
      private_ip    = string
      disk_size     = number
    })
  )

  default = {
    "sauron" = {
      name = "sauron"
      ami_id = "ami-08f173bf94c7ac0a5"
      instance_type = "t3.micro"
      private_ip = "10.0.1.11"
      disk_size = 30
    },
    "bbdd01" = {
      name = "bbdd01"
      ami_id = "ami-08f173bf94c7ac0a5"
      instance_type = "t3.micro"
      private_ip = "10.0.1.111"
      disk_size = 30
    },
  }
}

module "instances_ec2" {
  source = "../../modules/ec2_instances"

  instances = {
    for instance, instance_data in var.instances :
    instance => {
      name          = instance_data.name
      ami_id        = instance_data.ami_id
      instance_type = instance_data.instance_type
      private_ip    = instance_data.private_ip
      disk_size     = instance_data.disk_size
      subnet_id     = aws_subnet.main_subnet_01.id
      creation      = local.terraform_tag
    }
  }

  depends_on_eip = aws_internet_gateway.main_internet_gw
}
