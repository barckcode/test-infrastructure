# EC2 Instance
resource "aws_instance" "instances" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  private_ip    = var.custom_private_ip
  key_name      = "ssh_key"

  root_block_device {
    volume_size = var.disk_size
  }

  tags = {
    Name     = var.tags_group["name"]
    Creation = var.tags_group["creation"]
  }
}
