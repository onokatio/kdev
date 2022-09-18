variable "nextcloud_db_password" {}

resource "aws_s3_bucket" "nextcloud" {
  bucket = "kdev-nextcloud"

  tags = {
    Name        = "Kdev Nextcloud"
  }
}

resource "aws_iam_user" "nextcloud" {
  name = "nextcloud"
}

resource "aws_db_subnet_group" "nextcloud" {
  name       = "nextcloud"
  subnet_ids = [aws_subnet.public-1a.id, aws_subnet.public-1c.id,aws_subnet.public-1d.id]

  tags = {
    Name = "nextcloud"
  }
}

resource "aws_security_group" "nextcloud-db" {
  name        = "nextcloud_db"
  description = "Allow connection for nextcloud db"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description      = "allow incoming mysql"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "nextcloud_db"
  }
}

resource "aws_rds_cluster" "nextcloud" {
  cluster_identifier = "nextcloud"
  engine             = "aurora-mysql"
  engine_mode        = "provisioned"
  engine_version     = "8.0.mysql_aurora.3.02.1"
  database_name      = "nextcloud"
  master_username    = "nextcloud"
  master_password    = "${var.nextcloud_db_password}"
  db_subnet_group_name = aws_db_subnet_group.nextcloud.name
  vpc_security_group_ids = [aws_security_group.nextcloud-db.id]
  availability_zones = [
    "ap-northeast-1a",
    "ap-northeast-1c",
    "ap-northeast-1d",
  ]
  skip_final_snapshot = true
  //final_snapshot_identifier = "nextcloud-final-snapshot"
  apply_immediately = true
  //backup_retention_period = 0

  serverlessv2_scaling_configuration {
    max_capacity = 1.0
    min_capacity = 0.5
  }
}

resource "aws_rds_cluster_instance" "nextcloud-1" {
  cluster_identifier = aws_rds_cluster.nextcloud.id
  instance_class     = "db.serverless"
  availability_zone = "ap-northeast-1a"
  engine             = aws_rds_cluster.nextcloud.engine
  engine_version     = aws_rds_cluster.nextcloud.engine_version
  db_subnet_group_name = aws_db_subnet_group.nextcloud.name
  publicly_accessible = true
}

resource "aws_rds_cluster_instance" "nextcloud-2" {
  cluster_identifier = aws_rds_cluster.nextcloud.id
  instance_class     = "db.serverless"
  availability_zone = "ap-northeast-1c"
  engine             = aws_rds_cluster.nextcloud.engine
  engine_version     = aws_rds_cluster.nextcloud.engine_version
  db_subnet_group_name = aws_db_subnet_group.nextcloud.name
  publicly_accessible = true
}

resource "aws_iam_user_policy_attachment" "nextcloud" {
  user = aws_iam_user.nextcloud.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_access_key" "nextcloud" {
  user = aws_iam_user.nextcloud.name
}

output "nextcloud_id" {
  value = aws_iam_access_key.nextcloud.id
}
output "nextcloud_secret" {
  value = aws_iam_access_key.nextcloud.secret
  sensitive = true
}
