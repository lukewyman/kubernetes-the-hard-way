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
  source = "${get_parent_terragrunt_dir()}/_resources/nlb"
}

dependency "vpc" {
  config_path = "../vpc"

  mock_outputs = {
    public_subnets = ["mock_subnet_1", "mock_subnet_2"]
    vpc_id = "mock_vpc_id"
  }

  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

dependency "ec2" {
  config_path = "../ec2"

  mock_outputs = {
    control_plane_ips = ["1.1.1.1", "2.2.2.2"]
    nlb_security_group_id = "mock_security_group_id"
  }
}

inputs = {
  app_name = local.app_name
  aws_region = local.aws_region
  control_plane_ips = dependency.ec2.outputs.control_plane_ips
  project_name = local.project_name
  public_subnets = dependency.vpc.outputs.public_subnets
  nlb_security_group_id = dependency.ec2.outputs.nlb_security_group_id
  vpc_id = dependency.vpc.outputs.vpc_id 
}