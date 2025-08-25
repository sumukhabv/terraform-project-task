module "vpc" {
  source             = "./modules/aws_vpc"
  cidr_block         = var.vpc_cidr_block
  vpc_name           = var.vpc_name
  public_subnet_cidr = var.vpc_public_subnet_cidr
  availability_zone  = var.vpc_availability_zone
}

module "ec2" {
  source        = "./modules/aws_ec2"
  ami_id        = var.ec2_ami_id
  instance_type = var.ec2_instance_type
  subnet_id     = module.vpc.subnet_id
  instance_name = var.ec2_instance_name
}

module "s3" {
  source      = "./modules/aws_s3"
  bucket_name = var.s3_bucket_name
}

module "aws_api_gateway" {
  source   = "./modules/aws_api_gateway"
  api_name = var.gateway_api_name
}

module "sns" {
  source         = "./modules/aws_sns"
  sns_topic_name = var.sns_topic_name
}
