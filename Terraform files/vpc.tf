# Resource Block
# Resource-1: Create VPC
resource "aws_vpc" "new-vpc" {
  cidr_block =  "10.10.0.0/16"
  tags = {
    "Name" = "new-vpc"
  } 
}

# Resource-2: Create Subnets
resource "aws_subnet" "vpc-new-public-subnet-1" {
  vpc_id = aws_vpc.new-vpc.id
  cidr_block = "10.10.1.0/24"
  availability_zone =  "ap-south-1a"
  map_public_ip_on_launch = true 
}

# Resource-3: Internet Gateway
resource "aws_internet_gateway" "vpc-new-igw" {
  vpc_id = aws_vpc.new-vpc.id  
}

# Resource-4: Create Route Table
resource "aws_route_table" "vpc-new-public-route-table" {
  vpc_id =  aws_vpc.new-vpc.id 
}

# Resource-5: Create Route in Route Table for Internet Access
resource "aws_route" "vpc-new-public-route" {
  route_table_id = aws_route_table.vpc-new-public-route-table.id  
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.vpc-new-igw.id
}

# Resource-6: Associate the Route Table with the Subnet
resource "aws_route_table_association" "vpc-new-public-route-table-asscoiate" {
 route_table_id = aws_route_table.vpc-new-public-route-table.id
 subnet_id = aws_subnet.vpc-new-public-subnet-1.id    
}