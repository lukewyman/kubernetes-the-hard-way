include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  vars = read_terragrunt_config(find_in_parent_folders("_common/vars.hcl"))
  app_name = local.vars.locals.app_name
  aws_region = local.vars.locals.region 
  project_name = local.vars.locals.project_name
}

terraform {
  source = "${get_parent_terragrunt_dir()}/_resources/ec2"
}

dependency "vpc" {
  config_path = "../vpc"

  mock_outputs = {
    public_subnets = ["mock_subnet_1", "mock_subnet_2"]
    vpc_id = "mock_vpc_id"
  }

  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

inputs = {
  app_name = local.app_name
  aws_region = local.aws_region
  host_names = {
    "controlplane01" = "controlplane"
    "controlplane02" = "controlplane"
    "node01" = "workers"
    "node02" = "workers"
  }
  instance_type = "t3.small"
  key_name = "kthw-keypair"
  public_subnets = dependency.vpc.outputs.public_subnets
  project_name = local.project_name
  vpc_id = dependency.vpc.outputs.vpc_id 
}