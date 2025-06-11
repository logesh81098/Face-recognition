##################################################################################################################################
#                                                      VPC
##################################################################################################################################

#VPC to launch EC2 and EKS

resource "aws_vpc" "Face-Recognition-vpc" {
  cidr_block = var.vpc-cidr
  tags = {
    Name = "Face-Recognition-vpc"
    Project = "Face Recognition"
  }
}

##################################################################################################################################
#                                                 Public Subnet
##################################################################################################################################

resource "aws_subnet" "public-subnet-1" {
  vpc_id = aws_vpc.Face-Recognition-vpc.id
  map_public_ip_on_launch = true
  cidr_block = var.subnet-1-cidr
  availability_zone = var.az1
  tags = {
    Name = "Face-Recognition-public-subnet-1"
    Project = "Face Recognition"
  }
}


resource "aws_subnet" "public-subnet-2" {
  vpc_id = aws_vpc.Face-Recognition-vpc.id
  map_public_ip_on_launch = true
  cidr_block = var.subnet-2-cidr
  availability_zone = var.az2
  tags = {
    Name = "Face-Recognition-public-subnet-2"
    Project = "Face Recognition"
  }
}


##################################################################################################################################
#                                                 Internet Gateway
##################################################################################################################################

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.Face-Recognition-vpc.id
  tags = {
    Name = "Face-Recognition-IGW"
    Project = "Face Recognition"
  }
}


##################################################################################################################################
#                                                   Route Table
##################################################################################################################################

resource "aws_route_table" "Face-Recognition-RT" {
  vpc_id = aws_vpc.Face-Recognition-vpc.id
  route {
    gateway_id = aws_internet_gateway.igw.id
    cidr_block = "0.0.0.0/0"
  }
  tags = {
    Name = "Face-Recognition-RT"
    Project = "Face Recognition"
  }
}


##################################################################################################################################
#                                               Route Table Association
##################################################################################################################################

resource "aws_route_table_association" "rt1" {
  route_table_id = aws_route_table.Face-Recognition-RT.id
  subnet_id = aws_subnet.public-subnet-1.id
}

resource "aws_route_table_association" "rt2" {
  route_table_id = aws_route_table.Face-Recognition-RT.id
  subnet_id = aws_subnet.public-subnet-2.id
}