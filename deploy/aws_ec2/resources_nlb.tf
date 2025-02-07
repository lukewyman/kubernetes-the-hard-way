# resource "aws_lb" "nlb" {
#   name = "kthw-nlb"
#   load_balancer_type = "network"

#   tags = {
#     Name = "kthw-nlb"
#     Project = var.project_name
#   }
#   vpc_id = modules.kthw_vpc.vpc_id
# }

# resource "aws_lb_target_group" "controlplane_group" {
#   name = "kthw-controlplane" 
#   port = 80 
#   protocol = "HTTP" 
#   target_type = "ip"
#   vpc_id = modules.kthw_vpc.vpc_id
# }

# resource "aws_lb_target_group_attachment" "tga" {
#   for_each = {
#     for k, v in var.host_names : 
#     k => aws_instance.k8s_cluster_instance[k].public_ip
#     if v == "controlplane"
#   }

#   target_group_arn = aws_lb_target_group.controlplane_group.target_group_arn
#   target_id = each.value 
# }

resource "aws_security_group" "nlb_sg" {
  name = "nlb-sg"
  description = "Allow outside traffic in to the network load balancer"
  vpc_id = module.kthw_vpc.vpc_id 
}

resource "aws_security_group_rule" "nlb_outside_ingress" {
  security_group_id = aws_security_group.nlb_sg.id 
  type = "ingress"
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  from_port = 80
  to_port = 80
}