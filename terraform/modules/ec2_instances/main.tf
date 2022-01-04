# EC2 Instance
resource "aws_instance" "server" {
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
resource "aws_eip" "public_ips" {
  for_each = var.instances

  vpc = true
  instance                  = aws_instance.server[each.value.name].id
  associate_with_private_ip = aws_instance.server[each.value.name].private_ip
  depends_on                = [var.depends_on_eip]

  tags = {
    Name     = "${each.value.name}_public_ip"
		Creation = each.value.creation
  }
}
