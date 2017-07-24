resource "aws_elb" "default" {
    name               = "wp-elb-tf"
    subnets            = ["${var.subnet_preconf_id}"]
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

      instances                   = ["${aws_instance.ecs-instance01.id}"]
      cross_zone_load_balancing   = true
      idle_timeout                = 100


    tags {
        Name = "wp-elb-tf"
    }
}


