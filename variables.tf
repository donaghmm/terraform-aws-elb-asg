variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "us-east-1"
}

# ubuntu-trusty-16.04 (x64)
variable "aws_amis" {
  default = {
    "eu-west-1" = "ami-add175d4"
    "us-west-2" = "ami-0a00ce72"
  }
}

variable "availability_zones" {
  default     = "eu-west-1a,eu-west-1b,eu-west-1c"
  description = "List of availability zones, use AWS CLI to find your "
}

variable "key_name" {
  description = "Name of AWS key pair"
}

variable "instance_type" {
  default     = "t2.micro"
  description = "AWS instance type"
}

variable "asg_min" {
  description = "Min numbers of servers in ASG"
  default     = "12"
}

variable "asg_max" {
  description = "Max numbers of servers in ASG"
  default     = "18"
}

variable "asg_desired" {
  description = "Desired numbers of servers in ASG"
  default     = "12"
}
