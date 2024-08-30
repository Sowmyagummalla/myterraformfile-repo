# Resource-9: Create Tomcat EC2 Instances
resource "aws_instance" "tom-vm" {
    ami = var.ec2_ami_id
    instance_type = var.ec2_instance_type
    key_name = "Dockerdev"
    count = 2
    subnet_id = aws_subnet.jenk-vpc-public-subnet.id
    vpc_security_group_ids = [aws_security_group.jenk-vpc-sg.id]
    # user_data = file("tomcat-install.sh")
    user_data = <<-EOF
    #!/bin/bash
    sudo apt update -y
    sudo apt install maven -y
    sudo apt install unzip -y
    sudo wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.93/bin/apache-tomcat-9.0.93.tar.gz
    sudo tar -xvzf apache-tomcat-9.0.93.tar.gz
    EOF
    tags = {
      "Name" = "tom-vm"
    }

    root_block_device {
      volume_size = var.volume
    }
}