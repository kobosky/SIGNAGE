variable "aws_region" {
  type = string
  description = "aws region"
}


# VPC CIDR Block
variable "vpc_cidr" {
  description = "VPC CIDR Block"
  type = string 
  default = "10.0.0.0/16"
}

# VPC Public Subnet1
variable "public_subnet_az1_cidr" {
  description = "VPC Public Subnets 1"
  type = string
  default = "10.0.1.0/24"
}

# VPC Public Subnet2
variable "public_subnet_az2_cidr" {
  description = "VPC Public Subnets 2"
  type = string
  default = "10.0.2.0/24"
}

# VPC Private Subnet1
variable "private_subnet_app_az1_cidr" {
  description = "VPC Public Subnets 1"
  type = string
  default = "10.0.3.0/24"
}

# VPC Private Subnet2
variable "private_subnet_app_az2_cidr" {
  description = "VPC Public Subnets 2"
  type = string
  default = "10.0.4.0/24"
}
