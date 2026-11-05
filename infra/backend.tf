terraform {
  backend "s3" {
    bucket = "pgr301-terraform-state"
    key    = "wishifai/2/terraform.tfstate"
    region = "eu-west-1"
  }
}
