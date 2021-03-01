data "aws_vpc" "cluster_vpc" {
  tags = {
    cluster = var.cluster_name
  }
}
data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster" "current_cluster" {
  name = var.cluster_name
}

data "aws_subnet_ids" "private" {
  vpc_id = data.aws_vpc.cluster_vpc.id

  tags = {
    Tier = "private"
  }
}

data "aws_subnet" "private_subnets" {
  for_each = data.aws_subnet_ids.private.ids
  id       = each.value
}

