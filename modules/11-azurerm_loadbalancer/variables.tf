variable "lb_name" {
  description = "Name of the Load Balancer"
  type        = string
}

variable "location" {
  description = "Azure location for the resources"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "pip_id" {
  description = "Public IP ID for the Load Balancer frontend"
  type        = string
}

variable "vm1_nic_id" {
  description = "Network interface ID for VM1"
  type        = string
}

variable "vm2_nic_id" {
  description = "Network interface ID for VM2"
  type        = string
}
