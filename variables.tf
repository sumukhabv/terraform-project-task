variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "vpc_cidr_block" {
  description = "CIDR block for VPC"
  default     = "10.0.0.0/24"
}

variable "vpc_public_subnet_cidr" {
  type    = string
  default = "10.0.0.0/28"
}
variable "vpc_availability_zone" {}


variable "vpc_name" {}


variable "ec2_ami_id" {
  type    = string
  default = "ami-0871b7e0b83ae16c4"
}
variable "ec2_instance_type" {
  type    = string
  default = "t3.micro"
}
variable "ec2_instance_name" {}


variable "s3_bucket_name" {}

variable "gateway_api_name" {}


variable "sns_topic_name" {}
