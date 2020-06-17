
resource "aws_elasticache_cluster" "novelcovid_redis" {
  cluster_id           = "novelcovid-redis"
  engine               = "redis"
  node_type            = "cache.m4.large"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis3.2"
  engine_version       = "3.2.10"
  port                 = 6379
}

output "novelcovid_azs" {
  value = aws_elasticache_cluster.novelcovid_redis.availability_zones
}

output "novelcovid_cache_nodes" {
  value = aws_elasticache_cluster.novelcovid_redis.cache_nodes
}

