# Terraform AWS ELB ASG

## Prerequisites
Terraform installed on your system. if not please read instructions here https://www.terraform.io/downloads.html.


This creates a security group, launch configuration, auto scaling group and an ELB. The user data for launch configuration installs Apache Tomcat & configures AJP and it listens on port 80.

This terraform script uses Ubuntu 16.04 AMIs.

Make sure you change the list of availability zones that is applicable to your account and region.

To get started clone this repository

```
git clone git@github.com:harshadyeola/terraform-aws-elb-asg.git
cd terraform-aws-elb-asg
```


For planning phase

```
terraform plan -var 'key_name={your_key_name}'
```

For apply phase

```
terraform apply -var 'key_name={your_key_name}'
```
Once the stack is created, wait for few minutes and test the stack by launching a browser with ELB url.

To remove the stack

```
 terraform destroy -var 'key_name={your_key_name}'
```
