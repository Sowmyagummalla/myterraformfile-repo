# Resource-8: Create jenkins EC2 Instance
resource "aws_instance" "jenkins-vm" {
    ami = var.ec2_ami_id
    instance_type = var.ec2_instance_type
    key_name = "Dockerdev"
    count = 1
    subnet_id = aws_subnet.jenk-vpc-public-subnet.id
    vpc_security_group_ids = [aws_security_group.jenk-vpc-sg.id]
    # user_data = file("jenkins-install.sh")
     user_data = <<-EOF
              #!/bin/bash
              # Update the package list
              sudo apt-get update -y

              # Install Jenkins
              sudo apt-get install -y openjdk-11-jdk
              wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
              sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
              sudo apt-get update -y
              sudo apt-get install -y jenkins
              sudo systemctl start jenkins
              sudo systemctl enable jenkins

              # Install Trivy
              sudo apt update
              sudo apt install snapd
              sudo snap install trivy
            EOF  

    tags = {
      "Name" = "jenkins-vm"
    }

    root_block_device {
      volume_size = var.volume
    }
}
