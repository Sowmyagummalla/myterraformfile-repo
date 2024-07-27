# Input Variables
variable "aws_region" {
  description = "Region in which AWS resources to be created"
  type = string
  default = "ap-south-1"  
}

variable "ec2_ami_id" {
  description = "AMI ID"
  type = string
  default = "ami-068e0f1a600cd311c" # Amazon Linux 2023 AMI ID 
}

variable "ec2_instance_count" {
  description = "EC2 INSTANCE COUNT"
  type = number
  default = 1  
}