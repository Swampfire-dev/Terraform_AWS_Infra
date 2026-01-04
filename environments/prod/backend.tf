terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket-271225"
    key            = "prod/terraform.tfstate"
    region         = "ap-southeast-2"
    dynamodb_table = "terraform-lock-prod"
    encrypt        = true
  }
}
