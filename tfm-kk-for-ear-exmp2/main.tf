resource "aws_iam_user" "IAM" {
  name =  each.value
  for_each      = toset(split(":",var.cloud_users))
 # for_each      = toset(["giri","sada"])
}

# resource "aws_instance" "ruby" {
#   ami           = var.ami
#   instance_type = var.instance_type
#   for_each      = var.name
#   key_name      = var.key_name
#   tags = {
#     Name = each.value
#   }
# }
# output "instances" {
#   value = aws_instance.ruby
# }

# variable "name" {
#   type    = set(string)
#   default = ["jade-webserver", "jade-lbr", "jade-app1", "jade-agent", "jade-app2"]

# }
# variable "cloud_users" {
#      default = "andrew:ken:faraz:mutsumi:peter:steve:braja"

# }

# iac-server $ cat /var/answers/answer6.tf
# resource "aws_iam_user" "cloud" {
#      name = split(":",var.cloud_users)[count.index]
#      count = length(split(":",var.cloud_users))

# }

# What is the name of the IAM User that is created at the Index 6, of the IAM User at 
# address aws_iam_user.cloud ?


# Use the terraform console to find out.
# You can either do this in the interactive console or a one liner like this:
# echo 'aws_iam_user.cloud[6].name' | terraform console


