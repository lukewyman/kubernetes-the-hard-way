remote_state {
  backend = "s3"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }

  config = {
    bucket               = "kthw-tofu-state"
    key                  = "${path_relative_to_include()}/tofu.tfstate"
    encrypt              = true
    dynamodb_table       = "kthw-tofu-state"
    region               = "us-west-2"
    workspace_key_prefix = "kthw"
  }
}

generate "provider_versions" {
  path = "provider_versions.tf"
  if_exists = "overwrite"

  contents = <<EOF
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.85.0"
    }
  }
}
  EOF
}