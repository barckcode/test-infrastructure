# EC2 Instance
resource "aws_instance" "servidor" {
  for_each = var.servidores

  ami                    = each.value.ami_id
  instance_type          = var.tipo_instancia
  subnet_id              = each.value.subnet_id

  tags = {
    Name = each.value.nombre
  }
}


# Elastic IP
# resource "aws_eip" "public_ips" {
#   vpc = true

#   instance                  = var.id_instance_eip
#   associate_with_private_ip = var.custom_private_ip
#   depends_on                = [var.depends_on_eip]

#   tags = {
#     Name     = "${var.tags_group["name"]}_public_ip"
# 		Creation = var.tags_group["creation"]
#   }
# }
