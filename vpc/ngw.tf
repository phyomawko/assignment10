

resource "aws_eip" "ass10_eip" {
    

    tags = {
        Name = "ass10-eip"
    }
}

resource "aws_nat_gateway" "ass10_ngw" {
    
    allocation_id = aws_eip.ass10_eip.id
    subnet_id     = aws_subnet.ass10_pub_subnet1.id

    tags = {
        Name = "ass10-ngw"
    }
}