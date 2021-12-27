locals {
	#
	# Global Vars
	##
	region_zone = "eu-west-1"
	availability_zone_a = "a"
	availability_zone_b = "b"
	prefix_prod = "prod"
	terraform_tag = "terraform"


	default_ami = "ami-08f173bf94c7ac0a5"	# aragon-ami-v1
	default_instance_type = "t3.micro"
}
