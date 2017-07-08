resource "aws_elb" "default" {
    name               = "wp-elb-tf"
    subnets            = ["subnet-11111"]
    security_groups    = ["${aws_security_group.wp-elb-tf.id}"]

    listener {
        instance_port     = 80
        instance_protocol = "http"
        lb_port           = 80
        lb_protocol       = "http"
    }

    health_check {
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 5
        target              = "HTTP:80/"
        interval            = 30
    }

    tags {
        Name = "wp-elb-tf"
    }
}


