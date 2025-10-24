variable "resource_group_name" {
  type        = string
  default     = "devops-rg"
}

variable "location" {
  type        = string
  default     = "East US"
}

variable "admin_password" {
  description = "Admin password for the VM"
  type        = string
  sensitive   = true
}



