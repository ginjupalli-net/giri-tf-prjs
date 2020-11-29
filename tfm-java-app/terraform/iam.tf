#https://medium.com/@devopslearning/aws-iam-ec2-instance-role-using-terraform-fa2b21488536
resource "aws_iam_role" "ec2_assume_role" {
  name = "ec2_assume_role_${terraform.workspace}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
      name = "ec2_assume_role_${terraform.workspace}"
  }
}

resource "aws_iam_instance_profile" "devops_ec2_profile" {
  name = "devops_ec2_profile_${terraform.workspace}"
  role = aws_iam_role.ec2_assume_role.name
}

resource "aws_iam_role_policy" "devops_s3_policy" {
  name = "devops_s3_policy_${terraform.workspace}"
  role = aws_iam_role.ec2_assume_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
