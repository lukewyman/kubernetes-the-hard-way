variable "aws_region" {
  type = string 
  default = "us-west-2"
}

variable "project_name" {
  type = string 
  default = "Kubernetes the Hard Way"
}

### EC2 
variable "host_names" {
  type = map(string)
  default = {
    "controlplane01" = "controlplane"
    "controlplane02" = "controlplane"
    "node01" = "workers"
    "node02" = "workers"
  }
}

### NLB


### VPC
variable "vpc_cidr_block" {
  description = "VPC CIDR block"
  type        = string
  default = "10.0.0.0/16"
}

variable "vpc_public_subnets" {
  description = "Public subnets"
  type = list(string)
  default = ["10.0.101.0/24"]
}

variable "vpc_private_subnets" {
  description = "Private subnets"
  type = list(string)
  default = []
}