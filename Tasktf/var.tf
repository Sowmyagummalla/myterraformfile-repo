# Input Variables
variable "aws_region" {
  description = "Region in which AWS resources to be created"
  type = string
}

variable "ec2_instance_type" {
  description = "Type of AWS EC2 Instance"
  type = string
}

variable "ec2_ami_id" {
  description = "AMI ID"
  type = string
}

variable "volume" {
  description = "Root volume of the instance"
  type = string 
}