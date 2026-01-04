terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket-271225"
    key            = "global/terraform.tfstate"
    region         = "ap-southeast-2"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}
