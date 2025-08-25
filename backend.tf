terraform {
  backend "s3" {
    bucket = "terraform--task1"
    key    = "backend_folder/terraform.tfstate"
    region = "us-east-1"
  }
}

