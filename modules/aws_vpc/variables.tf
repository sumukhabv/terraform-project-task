variable "cidr_block" {
	type = string
	default = "10.0.0.0/24"
}
variable "vpc_name" {}
variable "public_subnet_cidr" {
	type = string
	default = "10.0.0.0/28"
}
variable "availability_zone" {}

