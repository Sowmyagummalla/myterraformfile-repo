# Resource-8: Create EC2 Instance
resource "aws_instance" "jenk-vm" {
   ami = var.ec2_ami_id
   instance_type = var.ec2_instance_type
   key_name = "Dockerdev"
   count = 1
   subnet_id = aws_subnet.jenk-vpc-public-subnet.id
   vpc_security_group_ids = [aws_security_group.jenk-vpc-sg.id]
   #user_data = file("jenkins-install.sh")
   user_data = <<-EOF
   #!/bin/bash
   sudo apt-get update -y
   sudo apt install maven -y
   # Install dependencies
   sudo apt update
   sudo apt install -y openjdk-11-jdk

   # Add the Jenkins repository key to your system
   curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee \
   /usr/share/keyrings/jenkins-keyring.asc > /dev/null

   # Add the Jenkins repository to your system's package sources
   echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
   https://pkg.jenkins.io/debian binary/ | sudo tee \
   /etc/apt/sources.list.d/jenkins.list > /dev/null

   # Update package list and install Jenkins
   sudo apt update
   sudo apt install -y jenkins

   sudo systemctl start jenkins
   sudo systemctl status jenkins
   sudo apt update
   sudo apt install snapd
   sudo snap install trivy
   EOF
   tags = {
    "Name" = "jenk-vm"
   }

    root_block_device {
     volume_size = var.volume
    }


}