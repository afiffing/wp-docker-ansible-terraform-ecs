
variable "vpc_cidr_block" {
  description = "VPC network"
  default     = "172.31.0.0/16"
}

variable "public_subnet_cidr_block" {
  description = "Public Subnet"
  default     = "172.31.0.0/16"
}

variable "private_subnet_cidr_block" {
  description = "Private Subnet"
  default     = "172.31.0.0/16"
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
    us-west-2      = "ami-a58d0dc5"
  }
}

variable "instance_type" {
  description = "EC2 instance type"
  default = "t2.micro"
}


variable "key_name" {
  description = "SSH key name to access the EC2 instances"
  default = "random-keyname-ecs"
}

variable "db_name" {
  description = "RDS DB name"
  default = "wordpress_ansible"
}

variable "db_user" {
  description = "RDS DB username"
  default = "randomuser"
}

variable "db_password" {
  description = "RDS DB password"
  default = "randompassword"
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
  default = "randompasspart2"
}

variable "wp_mail" {
  description = "Wordpress email"
  default = "abctestemail@gmail.com"
}
