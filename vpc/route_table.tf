resource "aws_route_table" "ass10_pub_rt" {
    vpc_id = aws_vpc.ass10_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.ass10_igw.id
  
}
}
resource "aws_route_table_association" "ass10_pub_rt_association1" {
    subnet_id = aws_subnet.ass10_pub_subnet1.id
    route_table_id = aws_route_table.ass10_pub_rt.id
}
resource "aws_route_table_association" "ass10_pub_rt_association2" {
    subnet_id = aws_subnet.ass10_pub_subnet2.id
    route_table_id = aws_route_table.ass10_pub_rt.id
}
resource "aws_route_table" "ass10_pri_rt" {
    vpc_id = aws_vpc.ass10_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.ass10_ngw.id
    } 
}
resource "aws_route_table_association" "ass10_pri_rt_association1" {
    subnet_id = aws_subnet.ass10_pri_subnet1.id
    route_table_id = aws_route_table.ass10_pri_rt.id
}
resource "aws_route_table_association" "ass10_pri_rt_association2" {
    subnet_id = aws_subnet.ass10_pri_subnet2.id
    route_table_id = aws_route_table.ass10_pri_rt.id
}