variable "host_names" {
  type = dict(string)
  default = {
    "controlplane01" = "controlplane"
    "controlplane02" = "controlplane"
    "node01" = "workers"
    "node02" = "workers"
  }
}