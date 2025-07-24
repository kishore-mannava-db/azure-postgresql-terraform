# Azure PostgreSQL SQL Terraform Template

This template deploys an Azure PostgreSQL server with the following server parameters set (from screenshot ![image1](image1)):

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

## Usage

Update the variables in `variables.tf` as needed and apply using:

```bash
terraform init
terraform plan
terraform apply
```

## Customization

- Server configuration parameters reflect those from your screenshot.
- Update/add/remove `azurerm_postgresql_configuration` resources in `main.tf` to match your desired PostgreSQL settings.

## Output

- `server_fqdn`: The fully qualified domain name of the PostgreSQL server.