resource "aws_db_instance" "ass10_rds" {
    allocated_storage    = 20
    storage_type         = "gp2"
    engine               = "mysql"
    engine_version       = "8.0"
    instance_class       = "db.t3.micro"  # Free tier eligible instance class
    db_name              = var.db_name
    username             = var.db_username
    password             = var.db_password
    parameter_group_name = "default.mysql8.0"
    skip_final_snapshot  = true
    db_subnet_group_name = aws_db_subnet_group.ass10_rds_subnet_group.name  
    vpc_security_group_ids = [var.db_sg_id]
}

resource "aws_db_subnet_group" "ass10_rds_subnet_group" {
    name       = "ass10-rds-subnet-group"
    subnet_ids = [var.dbsubnet1, var.dbsubnet2]  

    tags = {
        Name = "ass10-rds-subnet-group"
    }
}