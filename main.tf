module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.8.1"

  name = "my-vpc"
  cidr = var.vpc_cidr
  azs  = var.azs

  private_subnets       = var.private_subnets
  public_subnets        = var.public_subnets
  public_subnet_suffix  = "public-subnet"
  private_subnet_suffix = "private-subnet"

  enable_dns_hostnames = true
  enable_nat_gateway   = true
  single_nat_gateway   = true

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.13.1"

  cluster_name    = "my-k8s"
  cluster_version = "1.29"

  cluster_endpoint_public_access           = true
  enable_cluster_creator_admin_permissions = true

  cluster_addons = {
    vpc-cni = {
      before_compute = true
      most_recent    = true
      configuration_values = jsonencode({
        env = {
          ENABLE_POD_ENI                    = "true"
          ENABLE_PREFIX_DELEGATION          = "true"
          POD_SECURITY_GROUP_ENFORCING_MODE = "standard"
        }
        nodeAgent = {
          enablePolicyEventLogs = "true"
        }
        enableNetworkPolicy = "true"
      })
    }
  }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  create_cluster_security_group = false
  create_node_security_group    = false

  eks_managed_node_group_defaults = {
    ami_type             = "AL2_x86_64"
    instance_types       = [var.instance_type]
    force_update_version = true
    capacity_type        = "SPOT"
  }

  eks_managed_node_groups = {
    one = {
      name = "node-group-1"

      min_size     = 1
      max_size     = 3
      desired_size = 1

      update_config = {
        max_unavailable_percentage = 50
      }
    }

    two = {
      name = "node-group-2"

      min_size     = 1
      max_size     = 2
      desired_size = 1

      update_config = {
        max_unavailable_percentage = 50
      }
    }
  }
}