terraform {
  backend "s3" {
    bucket         = "backend-bucket-783248773966"
    key            = "quoakka/migration/target-servers/terraform.tfstates"
    dynamodb_table = "terraform-lock"
  }
}