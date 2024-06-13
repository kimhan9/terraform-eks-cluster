env             = "dev"
region          = "ap-southeast-1"
vpc_cidr        = "10.0.0.0/16"
private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
public_subnets  = ["10.0.4.0/24", "10.0.5.0/24"]
azs             = ["ap-southeast-1a", "ap-southeast-1b"]
instance_type   = "t2.large"