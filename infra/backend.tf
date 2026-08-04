terraform {
  backend "s3" {
    bucket         = "memos-remote-state"
    key            = "memos/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "memos-remote-lock"
    encrypt        = true
  }
}
