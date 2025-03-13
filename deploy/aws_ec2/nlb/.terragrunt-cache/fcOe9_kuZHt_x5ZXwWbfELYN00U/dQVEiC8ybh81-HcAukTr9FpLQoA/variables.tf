variable "app_name" {
  default = "ansible-for-ec2"
}

variable "aws_region" {
  type = string 
  default = "us-west-2"
}

variable "control_plane_ips" {
  type = list(string)
}

variable "project_name" {
  type = string 
  default = "Ansible POC"
}

variable "public_subnets" {
  type = list(string)
}

variable "nlb_security_group_id" {
  type = string 
}

variable "vpc_id" {
  type = string 
}