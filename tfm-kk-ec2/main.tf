
resource "aws_instance" "cerberus" {
	ami = var.ami
     instance_type = var.instance_type
	key_name = aws_key_pair.cerberus-key.key_name
	#user_data = file("install_cicd_tools.sh")
	user_data = <<EOF
          #!/bin/bash
          sudo yum update -y
          sudo yum install nginx -y
          sudo systemctl start nginx
     EOF

     # tags = {
	# 	Name = "java-app-${terraform.workspace}"	
	# 	Batch = "devops"
	#}
}	
resource "aws_key_pair" "cerberus-key" {
  key_name   = "cerberus"
  public_key = file("/root/terraform-projects/project-cerberus/.ssh/cerberus.pub")
}

resource "aws_eip" "eip" {
  instance = aws_instance.cerberus.id
  vpc      = true
}
