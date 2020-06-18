
resource "aws_elasticache_cluster" "novelcovid_redis" {
  cluster_id           = "novelcovid-redis"
  engine               = "redis"
  node_type            = "cache.m4.large"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis3.2"
  engine_version       = "3.2.10"
  port                 = 6379
  subnet_group_name    = aws_elasticache_subnet_group.novelcovid_redis_subnet_group.name
  security_group_ids   = [aws_security_group.novelcovid_redis_sg.id]
}

resource "aws_elasticache_subnet_group" "novelcovid_redis_subnet_group" {
  name       = "novelcovid_redis_subnet_group"
  subnet_ids = [aws_subnet.master[0].id]
  depends_on = [
    aws_subnet.master
  ]
}

output "novelcovid_azs" {
  value = aws_elasticache_cluster.novelcovid_redis.availability_zones
}

output "novelcovid_cache_nodes" {
  value = aws_elasticache_cluster.novelcovid_redis.cache_nodes
}

resource "aws_security_group" "novelcovid_redis_sg" {
  name        = "novelcovid_redis_sg"
  description = "Elasticache redis to cluster"
  vpc_id      = aws_vpc.cluster.id

  ingress {
    description = "Inbound from VPC"
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.cluster.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "novelcovid_redis_sg"
  }
}