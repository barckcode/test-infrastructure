# EC2 Instance
resource "aws_instance" "servidor" {
  for_each = var.instances

  ami             = each.value.ami_id
  instance_type   = each.value.instance_type
  subnet_id       = each.value.subnet_id
  private_ip      = each.value.private_ip
  key_name        = "ssh_key"

  root_block_device {
    volume_size = each.value.disk_size
  }

  tags = {
    Name     = each.value.name
    Creation = each.value.creation
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
