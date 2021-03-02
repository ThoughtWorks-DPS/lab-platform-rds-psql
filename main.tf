#############
# RDS Aurora
#############
module "aurora" {
  source                = "terraform-aws-modules/rds-aurora/aws"
  version               = "~> 3.0"
  name                  = var.cluster_name
  engine                = "aurora-postgresql"
  engine_mode           = "serverless"
  engine_version        = "10.12"
  replica_scale_enabled = false
  replica_count         = 0
  database_name         = "root"
  backtrack_window      = 10 # ignored in serverless

  subnets                         = data.aws_subnet_ids.private.ids
  vpc_id                          = data.aws_vpc.cluster_vpc.id
  monitoring_interval             = 60
  instance_type                   = var.instance_type
  apply_immediately               = true
  skip_final_snapshot             = true
  storage_encrypted               = true
  db_parameter_group_name         = aws_db_parameter_group.aurora_db_postgresql10parameter_group.id
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.aurora_cluster_postgresql10parameter_group.id

  scaling_configuration = {
    auto_pause               = true
    max_capacity             = 4
    min_capacity             = 2
    seconds_until_auto_pause = 300
    timeout_action           = "ForceApplyCapacityChange"
  }
}

resource "aws_db_parameter_group" "aurora_db_postgresql10parameter_group" {
  name        = "${var.cluster_name}-aurora1012-parameter-group"
  family      = "aurora-postgresql10"
  description = "${var.cluster_name}-aurora-postgresql10-parameter-group"
}

resource "aws_rds_cluster_parameter_group" "aurora_cluster_postgresql10parameter_group" {
  name        = "${var.cluster_name}-1012-cluster-parameter-group"
  family      = "aurora-postgresql10"
  description = "${var.cluster_name}-aurora-postgresql10-cluster-parameter-group"
}

# resource "aws_security_group_rule" "allow_access" {
#  type                     = "ingress"
#  from_port                = 5432
#  to_port                  = 5432
#  protocol                 = "tcp"
#  source_security_group_id = data.aws_eks_cluster.cluster_primary_security_group_id
#  security_group_id        = module.aurora.this_security_group_id
# }
