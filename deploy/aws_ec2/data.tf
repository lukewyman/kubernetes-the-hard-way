data "aws_availability_zones" "available" {}

data "aws_ami" "ubuntu_jammy_amd64" {
  most_recent = true
  owners = ["099720109477"]
  
  filter {
    name = "name"
    values = ["ubuntu/images/*ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name = "architecture"
    values = ["x86_64"]
  }

  filter {
    name = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}