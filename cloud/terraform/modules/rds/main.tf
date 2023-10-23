variable db_subnet {} 

resource "aws_rds_cluster" "default" {
  cluster_identifier      = "db-cluster-seila"
  engine                  = "aurora-postgresql"
  engine_mode =  "serverless"
  engine_version          = "13.9"
  availability_zones      = ["us-east-1a"]
  master_username         = "toor"
  master_password         = "X69pnjjG2BJ4jaQ8QqBd"
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"
  skip_final_snapshot = true
  copy_tags_to_snapshot = true
  enable_http_endpoint = true

    scaling_configuration {
    auto_pause               = true
    max_capacity             = 2
    min_capacity             = 2
    seconds_until_auto_pause = 300
    timeout_action           = "ForceApplyCapacityChange"
  }
  lifecycle {
    ignore_changes = [ availability_zones ]
  }
}

# resource "aws_rds_cluster_instance" "cluster_instances" {
#   identifier         = "seila"
#   cluster_identifier = aws_rds_cluster.default.id
#   instance_class     = "db.servless"
#   engine             = aws_rds_cluster.default.engine
#   engine_version     = aws_rds_cluster.default.engine_version
# }

# resource "aws_db_subnet_group" "default" {
#   name       = "db_seila"
#   subnet_ids = [var.db_subnet.id]

#   tags = {
#     Name = "My DB subnet group"
#   }
# }