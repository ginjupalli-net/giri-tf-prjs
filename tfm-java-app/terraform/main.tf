provider "aws" {
	region = "us-east-1"
}
terraform {
  backend "s3" {
    bucket = "java-apps-dev"
    key    = "state/java-apps"
    region = "us-east-1"
  }
}


