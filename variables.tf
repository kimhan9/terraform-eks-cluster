variable "env" {
  description = "Environment"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}

variable "private_subnets" {
  description = "Private Subnets"
  type        = list(string)
}

variable "public_subnets" {
  description = "Public Subnets"
  type        = list(string)
}

variable "azs" {
  description = "Avaliablity Zones"
  type        = list(string)
}

variable "instance_type" {
  description = "Instance Type"
  type        = string
}