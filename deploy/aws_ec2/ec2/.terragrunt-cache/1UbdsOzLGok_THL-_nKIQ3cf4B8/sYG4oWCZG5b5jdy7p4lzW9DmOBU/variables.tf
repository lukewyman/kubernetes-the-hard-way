variable "app_name" {
  default = "ansible-for-ec2"
}

variable "aws_region" {
  type = string 
  default = "us-west-2"
}

variable "host_names" {
  type = map(string)
  default = {
    "controlplane01" = "controlplane"
    "controlplane02" = "controlplane"
    "node01" = "workers"
    "node02" = "workers"
  }
}

variable "instance_type" {
  type = string 
  default = "t3.small"
}

variable "key_name" {
  type = string 
  default = "kthw-keypair"
}

variable "public_subnets" {
  type = list(string) 
}

variable "project_name" {
  type = string 
  default = "Ansible POC"
}

variable "vpc_id" {
  type = string
}