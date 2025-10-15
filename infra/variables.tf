variable "resource_group_name" {
  type        = string
  default     = "devops-rg"
}

variable "location" {
  type        = string
  default     = "East US"
}

variable "admin_username" {
  type        = string
  default     = "azureuser"
}

variable "admin_password" {
  type        = string
  description = "Admin password for VM"
}
