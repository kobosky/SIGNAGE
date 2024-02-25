# store the terraform state file in s3 and lock with dynamodb
terraform {
  backend "s3" {
    bucket         = "dosignage-terraform-state-1"
    key            = "terraform-module/signage/terraform.tfstate"
    region         = "eu-west-2"
    #profile        = "terraform"
    dynamodb_table = "terraform-state-lock"
  }
}
