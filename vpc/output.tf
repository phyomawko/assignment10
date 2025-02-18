
output "pub_subnet1_id" {
    value = aws_subnet.ass10_pub_subnet1.id
}
output "pub_subnet2_id" {
    value = aws_subnet.ass10_pub_subnet2.id
}
output "pri_subnet1_id" {
    value = aws_subnet.ass10_pri_subnet1.id
}
output "pri_subnet2_id" {
    value = aws_subnet.ass10_pri_subnet2.id
}
output "lb_sg_id" {
    value = aws_security_group.lb_sg.id
  
}
output "web_sg_id" {
    value = aws_security_group.web_sg.id
}
output "db_sg_id" {
    value = aws_security_group.db_sg.id
}
output "ass10_vpc_id" {
    value = aws_vpc.ass10_vpc.id
}
