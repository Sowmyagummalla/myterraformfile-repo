# Resource-8: Create EC2 Instance
resource "aws_instance" "terraform-ec2-vm" {
  ami = var.ec2_ami_id
  instance_type = "t2.micro"
  key_name = "clusterdev"
  count = var.ec2_instance_count
  subnet_id = aws_subnet.vpc-new-public-subnet-1.id
  vpc_security_group_ids = [aws_security_group.new-vpc-sg.id]
  #user_data = file("apache-install.sh")
  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install httpd -y
    sudo systemctl enable httpd
    sudo systemctl start httpd
    echo "<h1>WELCOME TO AWS EC2 CREATION USING TERRAFORM </h1>" > /var/www/html/index.html
    EOF
   tags = {
    "Name" = "terraform-ec2-vm"
   } 
}