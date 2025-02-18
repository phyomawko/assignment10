resource "aws_subnet" "ass10_pub_subnet1" {
    vpc_id = aws_vpc.ass10_vpc.id
    cidr_block =var.pub_subnet1_cidr
    availability_zone = "ap-southeast-1a"
    tags = {
      Name ="ass10_pub_subnet1"
    }
  
}
resource "aws_subnet" "ass10_pub_subnet2" {
    vpc_id = aws_vpc.ass10_vpc.id
    cidr_block = var.pub_subnet2_cidr
    availability_zone = "ap-southeast-1b"
    tags = {
      Name = "ass10_pub_subnet2"
    }
  

}
resource "aws_subnet" "ass10_pri_subnet1" {
    vpc_id = aws_vpc.ass10_vpc.id
    cidr_block = var.pri_subnet1_cidr
    availability_zone = "ap-southeast-1a"
    tags = {
      Name = "ass10_pri_subnet1"
    }
  

}
resource "aws_subnet" "ass10_pri_subnet2" {
    vpc_id = aws_vpc.ass10_vpc.id
    cidr_block = var.pri_subnet2_cidr
    availability_zone = "ap-southeast-1b"
    tags = {
      Name = "ass10_pri_subnet2"
    }
  

}