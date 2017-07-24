# ECS Container Instances

resource "aws_instance" "ecs-instance01" {
    ami                         = "${lookup(var.amis, var.region)}"
    instance_type               = "${var.instance_type}"
    availability_zone           = "us-west-2b"
    subnet_id                   = "${var.subnet_preconf_id}"
    key_name                    = "${var.key_name}"
    associate_public_ip_address = true
    security_groups             = ["${aws_security_group.wp-ecs-sg-tf.id}"]
    iam_instance_profile        = "ecsInstanceRole"
    user_data                   = "#!/bin/bash\necho ECS_CLUSTER=${aws_ecs_cluster.default.name} > /etc/ecs/ecs.config"
    tags {
      Name = "ecs-instance01"
    }
}
