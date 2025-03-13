resource "aws_lb" "lb" {
  name = "${var.app_name}-nlb"
  internal = false 
  load_balancer_type = "network" 
  subnets = [var.public_subnets[0]]
  security_groups = [var.nlb_security_group_id]

  tags = {
    Name = "${var.app_name}-nlb"
    Group = "loadbalancer"
    Project = var.project_name
  }
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.lb.arn
  port = "80"
  protocol = "TCP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.web_tg.arn
  }
}

resource "aws_lb_target_group" "web_tg" {
  name = var.app_name
  port = 80 
  protocol = "TCP"
  target_type = "ip"
  vpc_id = var.vpc_id 
}

resource "aws_lb_target_group_attachment" "ip_attachment" {
  for_each = toset(var.control_plane_ips) 

  target_group_arn = aws_lb_target_group.web_tg.arn
  target_id = each.key
}


