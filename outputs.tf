output "tg_arn" {
  value       = "${aws_lb_target_group.tg.arn}"
  description = "The ARN identifier of the created target group."
}

output "alb_arn" {
  value       = "${aws_lb.alb.arn}"
  description = "The ARN identifier of the created load balancer."
}

output "dns_name" {
  value       = "${aws_lb.alb.dns_name}"
  description = "The DNS name of the load balancer."
}
