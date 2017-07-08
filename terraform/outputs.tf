output "elb_dns" {
    value = "${aws_elb.default.dns_name}"
}

output "ecs_instance01" {
    value = "${aws_instance.ecs-instance01.public_ip}"
}
