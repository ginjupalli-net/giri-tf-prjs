provider "aws" {
	region = "us-east-1"
}

#resource "aws_key_pair" "terraform-demo" {
#  key_name   = "sada-linux-mac"
#  public_key = file("sada-linux-mac.pub")
#}

<<<<<<< HEAD
resource "aws_instance" "maven-instance" {
	# Ubuntu linux ami
=======
resource "aws_instance" "my-instance" {
>>>>>>> 4e6f469e636af2c400bf8ec828469f18325bb93c
	ami = "ami-04169656fea786776"
	instance_type = "t2.small"
	key_name = "DevOps-ec2-kp"
	iam_instance_profile = aws_iam_instance_profile.devops_ec2_profile.name
	#key_name = aws_key_pair.terraform-demo.key_name
<<<<<<< HEAD
	user_data = file("install_apache.sh")
	tags = {
		Name = "maven01"	
		Batch = "devops"
	}
}

resource "aws_instance" "nexus-instance" {
	# Amazon linux ami
	ami = "ami-0947d2ba12ee1ff75"
	instance_type = "t2.medium"
	key_name = "DevOps-ec2-kp"
	iam_instance_profile = aws_iam_instance_profile.devops_ec2_profile.name
	#key_name = aws_key_pair.terraform-demo.key_name
	# This installs java,nexsus server
	user_data = file("install_nexus.sh")
	tags = {
		Name = "nexus01"	
		Batch = "devops"
	}
}	
resource "aws_instance" "jenkins-instance" {
	# Amazon linux ami
	ami = "ami-0947d2ba12ee1ff75"
	instance_type = "t2.medium"
	key_name = "DevOps-ec2-kp"
	iam_instance_profile = aws_iam_instance_profile.devops_ec2_profile.name
	#key_name = aws_key_pair.terraform-demo.key_name
	# This installs java,nexsus server
	user_data = file("install_jenkins.sh")
	tags = {
		Name = "jenkins01"	
		Batch = "devops"
	}
}	
=======
#	user_data = "${file("install_apache.sh")}"
	user_data = file("install_apache.sh")
	tags = {
		Name = "Terraform"	
		Batch = "devops"
	}
}
>>>>>>> 4e6f469e636af2c400bf8ec828469f18325bb93c
