resource "aws_eks_cluster" "cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.master.arn

  vpc_config {
    subnet_ids = flatten([aws_subnet.master.*.id, aws_subnet.worker.*.id])
  }

  depends_on = [
    aws_iam_role_policy_attachment.cluster,
    aws_iam_role_policy_attachment.service,
  ]
}

resource "aws_eks_node_group" "cluster" {

  for_each = var.worker_groups

  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = each.key
  node_role_arn   = aws_iam_role.worker.arn
  subnet_ids      = aws_subnet.worker.*.id

  instance_types = [
    each.value.instance_type
  ]

  scaling_config {
    desired_size = each.value.desired_size
    max_size     = each.value.maximum_size
    min_size     = each.value.minimum_size
  }

  depends_on = [
    aws_iam_role_policy_attachment.cni,
    aws_iam_role_policy_attachment.registry,
    aws_iam_role_policy_attachment.worker,
  ]
}
