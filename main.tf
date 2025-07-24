terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  required_version = ">= 1.0"
}

provider "azurerm" {
  features {}
}

# Try to get existing resource group
data "azurerm_resource_group" "existing" {
  count = 1
  name  = var.resource_group_name
}

# Create resource group if it doesn't exist
resource "azurerm_resource_group" "new" {
  count    = length(data.azurerm_resource_group.existing) == 0 ? 1 : 0
  name     = var.resource_group_name
  location = var.location
}

# Local value to get the resource group (either existing or new)
locals {
  resource_group = length(data.azurerm_resource_group.existing) > 0 ? data.azurerm_resource_group.existing[0] : azurerm_resource_group.new[0]
}

# PostgreSQL Flexible Server
resource "azurerm_postgresql_flexible_server" "example" {
  name                = var.server_name
  location            = local.resource_group.location
  resource_group_name = local.resource_group.name

  administrator_login    = var.admin_username
  administrator_password = var.admin_password

  sku_name = var.sku_name
  version  = var.postgres_version

  storage_mb = var.storage_mb

  backup_retention_days        = var.backup_retention_days
  geo_redundant_backup_enabled = var.geo_redundant_backup_enabled

  tags = var.tags
}

# Firewall Rule to allow all IP addresses
resource "azurerm_postgresql_flexible_server_firewall_rule" "allow_all" {
  name             = "allow-all-ips"
  server_id        = azurerm_postgresql_flexible_server.example.id
  start_ip_address = "0.0.0.255"
  end_ip_address   = "255.255.255.0"
}

# Server Parameters for Flexible Server
resource "azurerm_postgresql_flexible_server_configuration" "checkpoint_timeout" {
  name      = "checkpoint_timeout"
  server_id = azurerm_postgresql_flexible_server.example.id
  value     = "86400"
}

resource "azurerm_postgresql_flexible_server_configuration" "effective_cache_size" {
  name      = "effective_cache_size"
  server_id = azurerm_postgresql_flexible_server.example.id
  value     = "2147483647"
}

resource "azurerm_postgresql_flexible_server_configuration" "maintenance_work_mem" {
  name      = "maintenance_work_mem"
  server_id = azurerm_postgresql_flexible_server.example.id
  value     = "2097151"
}

resource "azurerm_postgresql_flexible_server_configuration" "max_parallel_maintenance_workers" {
  name      = "max_parallel_maintenance_workers"
  server_id = azurerm_postgresql_flexible_server.example.id
  value     = "64"
}

resource "azurerm_postgresql_flexible_server_configuration" "max_wal_senders" {
  name      = "max_wal_senders"
  server_id = azurerm_postgresql_flexible_server.example.id
  value     = "100"
}

resource "azurerm_postgresql_flexible_server_configuration" "max_wal_size" {
  name      = "max_wal_size"
  server_id = azurerm_postgresql_flexible_server.example.id
  value     = "65536"
}

resource "azurerm_postgresql_flexible_server_configuration" "wal_buffers" {
  name      = "wal_buffers"
  server_id = azurerm_postgresql_flexible_server.example.id
  value     = "262143"
}

resource "azurerm_postgresql_flexible_server_configuration" "work_mem" {
  name      = "work_mem"
  server_id = azurerm_postgresql_flexible_server.example.id
  value     = "2097151"
}
