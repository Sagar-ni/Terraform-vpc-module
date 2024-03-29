
resource "aws_vpc" "myvpc" {
  cidr_block           = var.cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project}-${var.Env}-vpc"
  }
}

##### Internet gateway######

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "${var.project}-${var.Env}-IGW"
  }
}


###### pUBLIC-SUBNETS ##########
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.myvpc.id
  availability_zone       = data.aws_availability_zones.available_1.names[0]
  cidr_block              = var.public_subnet_1_cidr
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project}-${var.Env}-public-subnet-1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.myvpc.id
  availability_zone       = data.aws_availability_zones.available_1.names[1]
  cidr_block              = var.public_subnet_2_cidr
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project}-${var.Env}-public-subnet-2"
  }
}

###### database subnets ########

resource "aws_subnet" "database_subnet_1" {
  vpc_id                  = aws_vpc.myvpc.id
  availability_zone       = data.aws_availability_zones.available_1.names[0]
  cidr_block              = var.database_subnet_1_cidr
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.project}-${var.Env}-database-subnet-1"
  }
}

resource "aws_subnet" "database_subnet_2" {
  vpc_id                  = aws_vpc.myvpc.id
  availability_zone       = data.aws_availability_zones.available_1.names[1]
  cidr_block              = var.database_subnet_2_cidr
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.project}-${var.Env}-database-subnet-2"
  }
}


###### Public Route table and rauting  igw on it  #########
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
  tags = {
    Name = "${var.project}-${var.Env}-public-route-table"

  }
}


####### database (Private) route table #########

resource "aws_route_table" "database_route_table" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "${var.project}-${var.Env}-database-route-table"

  }
}


############## subnet association #######

resource "aws_route_table_association" "public_route_table_association_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route_table.id

}

resource "aws_route_table_association" "public_route_table_association_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_route_table.id


}


resource "aws_route_table_association" "database_route_table_association_1" {
  subnet_id      = aws_subnet.database_subnet_1.id
  route_table_id = aws_route_table.database_route_table.id

}


resource "aws_route_table_association" "database_route_table_association_2" {
  subnet_id      = aws_subnet.database_subnet_2.id
  route_table_id = aws_route_table.database_route_table.id

}
