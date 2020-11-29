
resource "aws_instance" "java-app-instance" {
	# Amazon linux ami - us-east-1
	ami = "ami-04bf6dcdc9ab498ca"
    # AMI for us-west-1
   # ami = "ami-000279759c4819ddf"
    # 4 CPU 16G Mem
	instance_type = "t2.xlarge"
	key_name = "DevOps-ec2-kp"
	iam_instance_profile = aws_iam_instance_profile.devops_ec2_profile.name
	#key_name = aws_key_pair.terraform-demo.key_name
	# This installs java,nexsus server
	user_data = file("install_cicd_tools.sh")
	tags = {
		Name = "java-app-${terraform.workspace}"	
		Batch = "devops"
	}
}	