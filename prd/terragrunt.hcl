generate "provider" {
    path = "provider.tf"
    if_exists = "overwrite_terragrunt"
    contents = <<EOF
    provider "aws" {
        profile = "default"
        region = "eu-west-1"
        shared_credentials_files = ["~/.aws/credentials"]
    }
    EOF
}

remote_state {
  backend = "s3"
  generate = {
      path = "backend.tf"
      if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = "vw-demo-prd-730335502100-terraform-remote-backend"
    key    = "terraform-state-files/${path_relative_to_include()}/prd.terraform.tfstate"
    region = "eu-west-1"
    encrypt = true
    dynamodb_table = "vw-demo-prd-infra-terraform-locks"
  }
}

