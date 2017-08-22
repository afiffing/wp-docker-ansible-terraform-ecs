
variable "aws_access_key" {
  description = "AWS access key"
}

variable "aws_secret_key" {
  description = "AWS secret key"
}

variable "vpc_cidr_block" {
  description = "VPC network"
  default     = "172.31.0.0/16"
}

variable "public_subnet_cidr_block" {
  description = "Public Subnet"
  default     = "172.31.0.0/20"
}

variable "private_subnet_cidr_block" {
  description = "Private Subnet"
  default     = "172.31.16.0/20"
}

variable "region" {
  description = "AWS Region"
  default     = "us-west-2"
}

variable "availability_zones" {
  description = "Availability Zones"
  default     = "us-west-2a,us-west-2b,us-west-2c"
}

variable "ecs_cluster_name" {
  description = "ECS cluster Name"
  default     = "ecs-tf"
}

variable "amis" {
  description = "ECS Container Instances AMIs"
  default = {
    us-west-2      = "ami-57d9cd2e"
  }
}

variable "instance_type" {
  description = "EC2 instance type"
  default = "t2.micro"
}

variable "db_instance_type" {
  description = "RDS instance type"
  default = "db.t2.micro"
}

variable "key_name" {
  description = "SSH key name to access the EC2 instances"
}

variable "db_name" {
  description = "RDS DB name"
  default = "wp_ansible"
}

variable "db_user" {
  description = "RDS DB username"
  default = "testuser"
}

variable "db_password" {
  description = "RDS DB password"
}

variable "wp_title" {
  description = "Wordpress title"
  default = "wp-ansible-ecs"
}

variable "wp_user" {
  description = "Wordpress username"
  default = "admin"
}

variable "wp_password" {
  description = "Wordpress password"
}

variable "wp_mail" {
  description = "Wordpress email"
}