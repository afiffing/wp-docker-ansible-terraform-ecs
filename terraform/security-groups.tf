resource "aws_security_group" "wp-ecs-sg-tf" {
  name        = "wp-ecs-instance-tf"
  description = "Security group for EC2 Container Instances"
  vpc_id      = "${var.vpc_preconf_id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "wp-ecs-sg-tf"
  }
}



resource "aws_security_group" "wp-elb-tf" {
  name        = "wp-sg-elb-tf"
  description = "Security Group for the ELB"
  vpc_id      = "${var.vpc_preconf_id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "wp-sg-elb-tf"
  }
}
