output "psql_secret" {
  value     = module.aurora.this_rds_cluster_master_password
  sensitive = true
}

output "psql_master_username" {
  value = module.aurora.this_rds_cluster_master_username
}

output "psql_endpoint" {
  value = module.aurora.this_rds_cluster_endpoint
}