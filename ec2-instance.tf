# Resource-8: Create EC2 Instance
resource "aws_instance" "ansible-vm" {
  ami = "ami-0e86e20dae9224db8" # Ubuntu
  instance_type = "t2.micro"
  key_name = "Dockerdev"
  count = 1
  subnet_id = aws_subnet.ansiblevpc-public-subnet.id
  vpc_security_group_ids = [aws_security_group.ansiblevpc-sg.id]
  # user_data = file("apache-install.sh")
  user_data = <<-EOF
  #!/bin/bash
  sudo apt update -y
  sudo apt install apache2 -y
  echo "<h1>WELCOME TO ANSIBLE EC2 CREATION </h1>" > /var/www/html/index.html
  EOF
  tags = {
    "Name" = "ansible-vm"
  }

  root_block_device {
    volume_size = 30
  }
}