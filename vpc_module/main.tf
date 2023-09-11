#creating a vpc
resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_range["vpc"]

  tags = {
    "Name" = "ap1-vpc"
  }
}

#creating an internet gateway
resource "aws_internet_gateway" "igw" {
  depends_on = [aws_vpc.vpc, ]
  vpc_id     = aws_vpc.vpc.id #attaching VPC to internet gateway

  tags = {
    "Name" = "ap1-igw"
  }
}

#creating a public subnet 1
resource "aws_subnet" "publicsubnet1" {
  depends_on        = [aws_vpc.vpc, ]
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.cidr_range["publicsubnet"][0]
  availability_zone = var.avail_zone[0]

  tags = {
    "Name" = "ap1-public-s1"
  }
}

#creating a public subnet 2
resource "aws_subnet" "publicsubnet2" {
  depends_on        = [aws_vpc.vpc, ]
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.cidr_range["publicsubnet"][1]
  availability_zone = var.avail_zone[1]

  tags = {
    "Name" = "ap1-public-s2"
  }
}

#creating a public route table
resource "aws_route_table" "publicrt" {
  depends_on = [aws_vpc.vpc, aws_internet_gateway.igw, ]
  vpc_id     = aws_vpc.vpc.id

  tags = {
    "Name" = "ap1-public-rt"
  }
}

#creating a public route 1
resource "aws_route" "publicroute" {
  depends_on             = [aws_vpc.vpc, aws_internet_gateway.igw, aws_route_table.publicrt, ]
  route_table_id         = aws_route_table.publicrt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

#associating public routetable with public subnet 1
resource "aws_route_table_association" "public-s1rt-association" {
  depends_on     = [aws_vpc.vpc, aws_internet_gateway.igw, aws_subnet.publicsubnet1, aws_subnet.publicsubnet2, aws_route_table.publicrt, ]
  subnet_id      = aws_subnet.publicsubnet1.id
  route_table_id = aws_route_table.publicrt.id
}

#associating public routetable with public subnet 2
resource "aws_route_table_association" "public-s2rt-association" {
  depends_on     = [aws_vpc.vpc, aws_internet_gateway.igw, aws_subnet.publicsubnet1, aws_subnet.publicsubnet2, aws_route_table.publicrt, ]
  subnet_id      = aws_subnet.publicsubnet2.id
  route_table_id = aws_route_table.publicrt.id
}


