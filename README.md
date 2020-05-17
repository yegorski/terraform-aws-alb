# Terraform AWS Application Load Balancer

Terraform module to create an AWS Application Load Balancer.

> You can set up VPC and subnets with [terraform-aws-account-scaffolding][].

## Usage

```terraform
module "alb" {
  source = "git::https://github.com/yegorski/terraform-aws-alb.git?ref=master"

  name     = "APP_NAME"
  app_port = 5000

  security_group_id = "${aws_security_group.alb.id}"
  subnet_ids        = "${data.aws_subnet_ids.private.ids}"
  vpc_id            = "${data.terraform_remote_state.account.vpc_id}"

  tags = "${var.tags}"
}
```

## Notes

Pass `certificate_arn` to create HTTPS listener and an HTTP to HTTPS redirect.

[terraform-aws-account-scaffolding]: https://github.com/yegorski/terraform-aws-account-scaffolding
