# Generated by Terragrunt. Sig: nIlQXj57tbuaRZEa
terraform {
  backend "s3" {
    bucket               = "kthw-tofu-state"
    dynamodb_table       = "kthw-tofu-state"
    encrypt              = true
    key                  = "nlb/tofu.tfstate"
    region               = "us-west-2"
    workspace_key_prefix = "kthw"
  }
}
