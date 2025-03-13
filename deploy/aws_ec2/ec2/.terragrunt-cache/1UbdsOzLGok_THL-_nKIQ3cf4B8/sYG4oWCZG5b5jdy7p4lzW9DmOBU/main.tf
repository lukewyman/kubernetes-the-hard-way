resource "aws_instance" "k8s_cluster_instance" {
  for_each = var.host_names
  
  ami = data.aws_ami.ubuntu_jammy_amd64.id
  instance_type = var.instance_type

  key_name = var.key_name
  subnet_id = var.public_subnets[0]  # module.kthw_vpc.public_subnets[0]

  security_groups = [
    each.value == "controlplane" ? aws_security_group.controlplane_sg.id : aws_security_group.worker_sg.id
  ]

  tags = {
    Name = each.key
    Group = each.value
    Project = var.project_name
  }
}

resource "aws_security_group" "nlb_sg" {
  name = "${var.app_name}-nlb-sg"
  description = "Allow outside traffic in to the network load balancer"
  vpc_id = var.vpc_id 
}

resource "aws_security_group_rule" "nlb_outside_ingress" {
  security_group_id = aws_security_group.nlb_sg.id 
  type = "ingress"
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  from_port = 80
  to_port = 80
}

resource "aws_security_group" "controlplane_sg" {
  name = "controlplane-sg"
  description = "Allow inbound traffic from SSH and Network LB"
  vpc_id = var.vpc_id   # module.kthw_vpc.vpc_id
}

resource "aws_security_group_rule" "control_ssh_ingress" {
  security_group_id = aws_security_group.controlplane_sg.id
  type = "ingress" 
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  from_port = 22
  to_port = 22 
}

resource "aws_security_group_rule" "control_nlb_ingress" {
  security_group_id = aws_security_group.controlplane_sg.id 
  type = "ingress"
  protocol = "tcp"
  source_security_group_id = aws_security_group.nlb_sg.id
  from_port = 80
  to_port = 80
}

resource "aws_security_group" "worker_sg" {
  name = "worker-sg" 
  description = "Allow inbound traffic from SSH and control-plane-sg"
  vpc_id = var.vpc_id   # module.kthw_vpc.vpc_id 
}

resource "aws_security_group_rule" "worker_ssh_ingress" {
  security_group_id = aws_security_group.worker_sg.id
  type = "ingress" 
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  from_port = 22
  to_port = 22 
}

resource "aws_security_group_rule" "worker_control_ingress" {
  security_group_id = aws_security_group.worker_sg.id
  type = "ingress" 
  protocol = "tcp"
  source_security_group_id = aws_security_group.controlplane_sg.id 
  from_port = 80 
  to_port = 80
}