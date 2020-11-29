provider "aws" {
	region = "us-east-1"
}
terraform {
  backend "s3" {
    bucket = "vg-devops"
    key    = "state/jenkins"
    region = "us-east-1"
  }
}

data "aws_iam_instance_profile" "ec2-profile" {
  name = "devops_ec2_profile"
}

resource "aws_instance" "jenkins-instance" {
	# Amazon linux ami
	ami = "ami-04bf6dcdc9ab498ca"
	instance_type = "t2.medium"
	key_name = "DevOps-ec2-kp"
	iam_instance_profile = data.aws_iam_instance_profile.ec2-profile.name
	#key_name = aws_key_pair.terraform-demo.key_name
	# This installs java,nexsus server
	user_data = file("install_jenkins.sh")
	tags = {
		Name = "jenkins01"	
		Batch = "devops"
	}
}	