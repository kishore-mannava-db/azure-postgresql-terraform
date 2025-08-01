variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "East US"
}

variable "server_name" {
  description = "Name of the PostgreSQL server"
  type        = string
}

variable "admin_username" {
  description = "Administrator username"
  type        = string
}

variable "admin_password" {
  description = "Administrator password"
  type        = string
  sensitive   = true
}

variable "sku_name" {
  description = "The SKU name for the server (e.g., B_Gen5_1)"
  type        = string
  default     = "MO_Standard_E64ds_v5"
}

variable "postgres_version" {
  description = "The version of PostgreSQL to use (e.g., 11)"
  type        = string
  default     = "15"
}


variable "storageSizeGB" {
  description = "Storage size in GB (will be converted to MB)"
  type        = number
  default     = 512
}

variable "iopsTier" {
  description = "IOPS tier for the storage (P4, P6, P10, P15, P20, P30, P40, P50, P60, P70, P80)"
  type        = string
  default     = "P40"
}

variable "auto_grow_enabled" {
  description = "Enable auto-growing storage"
  type        = bool
  default     = true
}

variable "backup_retention_days" {
  description = "Days to retain backups"
  type        = number
  default     = 7
}

variable "geo_redundant_backup_enabled" {
  description = "Enable geo-redundant backup"
  type        = bool
  default     = false
}

variable "public_network_access_enabled" {
  description = "Enable public network access"
  type        = bool
  default     = true
}

variable "ssl_enforcement_enabled" {
  description = "Enable SSL enforcement"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to assign to resources"
  type        = map(string)
  default     = {}
}