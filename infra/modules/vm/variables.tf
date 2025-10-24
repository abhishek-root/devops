variable "resource_group_name" {}
variable "location" {}
variable "subnet_id" {}
variable "vm_name" {}

variable "admin_username" {
  description = "VM admin username"
  type        = string
}

variable "admin_password" {
  description = "VM admin password"
  type        = string
  sensitive   = true
}



