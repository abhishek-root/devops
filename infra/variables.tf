variable "resource_group_name" {
  type        = string
  default     = "devops-rg"
}

variable "location" {
  type        = string
  default     = "East US"
}

variable "admin_password" {
  type      = string
  sensitive = true
  description = "Admin password for the Linux VM"
}


