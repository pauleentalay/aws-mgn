terraform {
  backend "s3" {
    bucket         = "backend-bucket-783248773966"
    key            = "quoakka/migration/source-server/terraform.tfstates"
    dynamodb_table = "terraform-lock"
  }
}