# Azure PostgreSQL Flexible Server Terraform Template

This template deploys an Azure PostgreSQL Flexible Server with the following server parameters set:

| Parameter                       | Value      |
|----------------------------------|------------|
| checkpoint_timeout               | 86400      |
| effective_cache_size             | 2147483647 |
| maintenance_work_mem             | 2097151    |
| max_parallel_maintenance_workers | 64         |
| max_wal_senders                  | 100        |
| max_wal_size                     | 65536      |
| wal_buffers                      | 262143     |
| work_mem                         | 2097151    |

## Prerequisites

- Azure CLI installed and authenticated
- Terraform installed (version >= 1.0)
- Azure subscription with appropriate permissions

## Setup

### 1. Create terraform.tfvars file

Create a `terraform.tfvars` file in the root directory with your specific values:

```bash
# Example terraform.tfvars
resource_group_name = "your-resource-group-name"
location           = "East US"
server_name        = "your-postgresql-server-name"
admin_username     = "your-admin-username"
admin_password     = "password"
```

**Important Notes:**
- Replace `your-resource-group-name` with your desired resource group name
- Replace `your-postgresql-server-name` with a unique server name (lowercase letters, numbers, hyphens only, 3-63 characters)
- Replace `your-admin-username` with your desired admin username
- Replace `YourSecurePassword123!` with a secure password that meets Azure requirements:
  - At least 8 characters
  - Contains uppercase letters, lowercase letters, numbers, and special characters

### 2. Initialize and Deploy

```bash
terraform init
terraform plan
terraform apply
```

## Configuration

- **Server Type**: PostgreSQL Flexible Server
- **SKU**: Standard_D2ds_v4 (General Purpose, 2 vCores)
- **PostgreSQL Version**: 15
- **Storage**: 32 GB minimum
- **Firewall**: Configured to allow all IP addresses (0.0.0.0/0)

## Customization

- Update/add/remove `azurerm_postgresql_flexible_server_configuration` resources in `main.tf` to match your desired PostgreSQL settings
- Modify the SKU in `variables.tf` for different performance tiers
- Adjust firewall rules in `main.tf` for more restrictive access

## Output

- `server_fqdn`: The fully qualified domain name of the PostgreSQL server.

## Security Notes

⚠️ **Important Security Considerations:**
- The firewall rule allows access from all IP addresses (0.0.0.0/0). In production, restrict this to specific IP ranges
- Consider using Azure Private Link or VNet integration for more secure access
- Ensure strong passwords and proper authentication mechanisms
- Review and adjust security settings based on your requirements