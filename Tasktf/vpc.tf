# Resources Block
# Resource-1: Create VPC
resource "aws_vpc" "jenk-vpc" {
    cidr_block = "10.10.0.0/16"
    tags = {
        "Name" = "jenk-vpc"
    }
}

# Resource-2: Create Subnets
resource "aws_subnet" "jenk-vpc-public-subnet" {
 vpc_id = aws_vpc.jenk-vpc.id
 cidr_block = "10.10.1.0/24"
 availability_zone = "us-east-1a"
 map_public_ip_on_launch = true
}

# Resource-3: Create Internet Gateway
resource "aws_internet_gateway" "jenk-vpc-igw" {
  vpc_id = aws_vpc.jenk-vpc.id
}

# Resource-4: Create Route Table
resource "aws_route_table" "jenk-vpc-public-route-table" {
  vpc_id = aws_vpc.jenk-vpc.id
}

# Resource-5: Create Route in Route Table for Internet Access
resource "aws_route" "jenk-vpc-public-route" {
  route_table_id = aws_route_table.jenk-vpc-public-route-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.jenk-vpc-igw.id
}

# Resource-6: Associate the Route Table with the Subnet
resource "aws_route_table_association" "jenk-vpc-public-route-table-association" {
 route_table_id =  aws_route_table.jenk-vpc-public-route-table.id
 subnet_id = aws_subnet.jenk-vpc-public-subnet.id
}

# Resource-7: Create Security Group
resource "aws_security_group" "jenk-vpc-sg" {
  name = "jenk-vpc-default-sg"
  description = "Jenk VPC default Security Group"
  vpc_id = aws_vpc.jenk-vpc.id

  ingress{
    description = "Allow Port 22"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress{
    description = "Allow Port 8080"
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress{
    description = "Allow all IP and Ports Outbound"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}