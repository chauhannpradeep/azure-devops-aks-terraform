variable "location" {
  default = "centralindia"
}

variable "resource_group_name" {
  default = "rg-aks-devops-demo"
}

variable "aks_cluster_name" {
  default = "aks-devops-demo"
}

variable "acr_name" {
  default = "acrdevopsdemo123"
}

variable "node_count" {
  default = 2
}

variable "node_vm_size" {
  default = "Standard_B2s_v2"  # best price/perf for free credits
}