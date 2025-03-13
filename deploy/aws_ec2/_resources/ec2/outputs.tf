output "nlb_security_group_id" {
  value = aws_security_group.nlb_sg.id
}

output "control_plane_ips" {
  value = [
    for k, v in var.host_names : aws_instance.k8s_cluster_instance[k].private_ip if v =="controlplane"
  ]
}