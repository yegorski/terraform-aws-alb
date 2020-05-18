resource "aws_lb" "alb" {
  name               = "${var.name}"
  internal           = "${var.load_balancer_interal}"
  load_balancer_type = "application"
  security_groups    = ["${var.security_group_id}"]
  subnets            = ["${var.subnet_ids}"]
  tags               = "${var.tags}"
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = "${aws_lb.alb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.tg.arn}"
    type             = "forward"
  }
}

resource "aws_lb_listener" "https_listener" {
  count = "${var.certificate_arn == "" ? 0 : 1}"

  load_balancer_arn = "${aws_lb.alb.arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-FS-2018-06"
  certificate_arn   = "${var.certificate_arn}"

  default_action {
    target_group_arn = "${aws_lb_target_group.tg.arn}"
    type             = "forward"
  }
}

resource "aws_lb_listener_rule" "redirect_http_to_https" {
  count = "${var.certificate_arn == "" ? 0 : 1}"

  listener_arn = "${aws_lb_listener.http_listener.arn}"

  action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  condition {
    path_pattern {
      values = ["*"]
    }
  }
}

resource "aws_lb_target_group" "tg" {
  name     = "${var.name}"
  port     = "${var.app_port}"
  protocol = "${var.protocol}"
  vpc_id   = "${var.vpc_id}"

  stickiness {
    type            = "lb_cookie"
    cookie_duration = 3600        # 1 hour
    enabled         = true
  }

  health_check {
    path     = "/"
    port     = "${var.app_port}"
    protocol = "${var.protocol}"
    matcher  = "200,301,302"
  }

  tags = "${var.tags}"
}
