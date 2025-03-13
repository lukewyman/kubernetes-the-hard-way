include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  vars = read_terragrunt_config(find_in_parent_folders("_common/vars.hcl"))
  aws_region = local.vars.locals.region 
  project_name = local.vars.locals.project_name
}

terraform {
  source = "${get_parent_terragrunt_dir()}/_resources/vpc"
}

inputs = {
  aws_region = local.aws_region 
  project_name = local.project_name
  vpc_cidr_block = "10.0.0.0/16"
  vpc_public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
}