##
## Tor bridges
###
## Bridge01
resource "aws_instance" "bridge01" {
  ami                  = local.default_ami
  instance_type        = local.default_instance_type
  subnet_id            = aws_subnet.main_subnet_01.id
  private_ip           = "10.0.1.50"
  key_name             = "ssh_key"
  iam_instance_profile = "CodeDeploy_EC2_DEPLOY_INSTANCE"

  root_block_device {
    volume_size = 30
  }

  tags = {
    Name     = "bridge01"
    Creation = "terraform"
  }
}


# Elastic IP
resource "aws_eip" "bridge01_public_ip" {
  vpc = true

  instance                  = aws_instance.bridge01.id
  associate_with_private_ip = "10.0.1.50"
  depends_on                = [aws_internet_gateway.main_internet_gw]

  tags = {
    Name     = "bridge01_public_ip"
    Creation = "terraform"
  }
}


# Attached Segurity Groups
resource "aws_network_interface_sg_attachment" "bridge01_sg_attachment" {
  security_group_id    = aws_security_group.bridge_sg.id
  network_interface_id = aws_instance.bridge01.primary_network_interface_id
}
