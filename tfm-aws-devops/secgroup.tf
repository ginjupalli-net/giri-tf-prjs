<<<<<<< HEAD
# #https://medium.com/@hmalgewatta/setting-up-an-aws-ec2-instance-with-ssh-access-using-terraform-c336c812322f
# resource "aws_security_group" "devops-sg" {
# name = "devops-sg"
# #vpc_id = aws_vpc.test-env.id}
# ingress {
#     cidr_blocks = [
#       "0.0.0.0/0"
#     ]
# from_port = 22
#     to_port = 22
#     protocol = "tcp"
# from_port = 
#     to_port = 80
#     protocol = "http"
# from_port = 
#     to_port = 443
#     protocol = "https"
# from_port = 
#     to_port = 443
#     protocol = "https"
#   }
# // Terraform removes the default rule
#   egress {
#    from_port = 0
#    to_port = 0
#    protocol = "-1"
#    cidr_blocks = ["0.0.0.0/0"]
#  }
# }
=======
#https://medium.com/@hmalgewatta/setting-up-an-aws-ec2-instance-with-ssh-access-using-terraform-c336c812322f
resource "aws_security_group" "devops-sg" {
name = "devops-sg"
#vpc_id = aws_vpc.test-env.id}
ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
from_port = 22
    to_port = 22
    protocol = "tcp"
from_port = 
    to_port = 80
    protocol = "http"
from_port = 
    to_port = 443
    protocol = "https"
from_port = 
    to_port = 443
    protocol = "https"
  }
// Terraform removes the default rule
  egress {
   from_port = 0
   to_port = 0
   protocol = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }
}
>>>>>>> 4e6f469e636af2c400bf8ec828469f18325bb93c
