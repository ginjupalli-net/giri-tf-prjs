provider "aws" {
  region = "us-east-2"
}

variable "instances_number" {
  default = 1
}

##################################################################
# Data sources to get VPC, subnet, security group and AMI details
##################################################################
data "aws_vpc" "default" {
  default = true
}
data "aws_vpc" "selected" {
  filter {
    name = "tag:Name"
    values = ["training-vpc"]
  }
}
data "aws_subnet" "selected" {
  filter {
    name = "tag:Name"
    values = ["training-vpc-private-us-east-2a"]
  }
}
#data "aws_subnet_ids" "all" {
#  vpc_id = data.aws_vpc.default.id
#}

#data "aws_ami" "amazon_linux" {
#  most_recent = true
#
#  owners = ["amazon"]
#
#  filter {
#    name = "name"
#
#    values = [
#      "amzn-ami-hvm-*-x86_64-gp2",
#    ]
#  }
#
##  filter {
#    name = "owner-alias"
#
#    values = [
#      "amazon",
#    ]
#  }
#}
data "aws_ssm_parameter" "ubuntu-focal" {
    name = "/aws/service/canonical/ubuntu/server/20.04/stable/current/amd64/hvm/ebs-gp2/ami-id"
}
data "aws_ami_ids" "amazon_linux" {
  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-hvm-*-x86_64-gp2"]
  }
}
module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 3.0"

  name        = "example"
  description = "Security group for example usage with EC2 instance"
  vpc_id      = data.aws_vpc.selected.id
#  vpc_id      = data.aws_vpc.default.id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "all-icmp"]
  egress_rules        = ["all-all"]
}

module "ec2" {
  source = "../../"

  instance_count = var.instances_number

  name                        = "example-with-ebs"
#  ami                         = "ami-03657b56516ab7912"
#  ami                         = data.aws_ami_ids.amazon_linux.id
  ami                         = data.aws_ssm_parameter.ubuntu-focal.value
  instance_type               = "t2.micro"
  subnet_id                   = data.aws_subnet.selected.id
#  subnet_id                   = tolist(data.aws_subnet_ids.all.ids)[0]
  vpc_security_group_ids      = [module.security_group.this_security_group_id]
  associate_public_ip_address = true
}

resource "aws_volume_attachment" "this_ec2" {
  count = var.instances_number

  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.this[count.index].id
  instance_id = module.ec2.id[count.index]
}

resource "aws_ebs_volume" "this" {
  count = var.instances_number

  availability_zone = module.ec2.availability_zone[count.index]
  size              = 1
}
