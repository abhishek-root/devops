variable "resource_group_name" {}
variable "location" {}
variable "subnet_id" {}
variable "vm_name" {}
variable "admin_password" {
  type      = string
  sensitive = true
  description = "Admin password for the VM"
}


