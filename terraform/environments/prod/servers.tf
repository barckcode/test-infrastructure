#
# Security Groups
##
# Sauron
resource "aws_security_group" "sauron_sg" {
  name        = "sauron_sg"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH from all"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name     = "sauron_sg"
    Creation = local.terraform_tag
  }
}

# BBDD
resource "aws_security_group" "bbdd_sg" {
  name        = "bbdd_sg"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24"]
  }

  # ingress {
  #   description = "SSH from all"
  #   from_port   = 22
  #   to_port     = 22
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  ingress {
    description = "MYSQL from VPC"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24"]
  }

  ingress {
    description = "MYSQL from K8"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name     = "bbdd_sg"
    Creation = local.terraform_tag
  }
}

variable "instances" {
  description = "Servers Map"

  type = map(object({
      name              = string
      ami_id            = string
      instance_type     = string
      private_ip        = string
      disk_size         = number
      security_group_id = string
    })
  )

  default = {
    "sauron" = {
      name              = "sauron"
      ami_id            = "ami-08f173bf94c7ac0a5"
      instance_type     = "t3.micro"
      private_ip        = "10.0.1.11"
      disk_size         = 30
      security_group_id = "sg-0550f3ea0d3f131b1" # sauron_sg
    },
    "bbdd01" = {
      name              = "bbdd01"
      ami_id            = "ami-08f173bf94c7ac0a5"
      instance_type     = "t3.micro"
      private_ip        = "10.0.1.111"
      disk_size         = 30
      security_group_id = "sg-058d2fb72c6f50a79" # bbdd_sg
    },
  }
}


#
# EC2
##
module "instances_ec2" {
  source = "../../modules/ec2_instances"

  instances = {
    for instance, instance_data in var.instances :
    instance => {
      name              = instance_data.name
      ami_id            = instance_data.ami_id
      instance_type     = instance_data.instance_type
      private_ip        = instance_data.private_ip
      disk_size         = instance_data.disk_size
      security_group_id = instance_data.security_group_id
      subnet_id         = aws_subnet.main_subnet_01.id
      creation          = local.terraform_tag
    }
  }

  depends_on_eip    = aws_internet_gateway.main_internet_gw
}
