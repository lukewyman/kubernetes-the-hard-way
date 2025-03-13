variable "aws_region" {
  type = string 
  default = "us-west-2"
}

variable "project_name" {
  type = string 
  default = "Kubernetes the Hard Way"
}

variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "vpc_public_subnets" {
  type = list(string)
  # default = ["10.0.1.0/24", "10.0.2.0/24"]
}