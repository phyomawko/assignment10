resource "aws_internet_gateway" "ass10_igw" {
    vpc_id = aws_vpc.ass10_vpc.id
    tags = {
        Name = "ass10_igw"
    }
  
}