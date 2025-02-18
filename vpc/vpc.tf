resource "aws_vpc" "ass10_vpc" {
    cidr_block = var.vpc_cidr
    tags = {
        Name = "ass10_vpc"
    }
  
}