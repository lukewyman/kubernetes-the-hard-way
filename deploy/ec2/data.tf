data "aws_ami" "image" {
  most_recent = true

  filter {
    name = "owners"
    values = ["099720109477"]
  }
  
  filter {
    name = "name"
    values = ["ubuntu/images/*ubuntu-jammy-22.04-amd64-server-*"]
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