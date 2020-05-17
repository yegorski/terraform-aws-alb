variable "certificate_arn" {
  type        = "string"
  description = "Certificate for the load balancer."
  default     = ""
}

variable "protocol" {
  type        = "string"
  description = "Protocol used by load balancer and target group."
  default     = "HTTP"
}

variable "name" {
  type        = "string"
  description = "Name of the project the network is being created for."
}

variable "app_port" {
  type        = "string"
  description = "The port the app is running to which the load balancer is pointing."
}

variable "region" {
  type        = "string"
  description = "The AWS region to use."
  default     = "us-east-1"
}

variable "security_group_id" {
  type        = "string"
  description = "ID of security group for the load balancer."
}

variable "subnet_ids" {
  type        = "list"
  description = "Subnet IDs for the load balancer."
}

variable "tags" {
  type        = "map"
  description = "A map of tags to apply to all resources."
}

variable "vpc_id" {
  type        = "string"
  description = "VPC with which to associate the target group with."
}
