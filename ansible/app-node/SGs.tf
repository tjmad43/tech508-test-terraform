# database security group 

resource "aws_security_group" "allow_ssh_http_3000" {
  name        = var.app_sg_name
  description = var.app_sg_name

    tags = {
    Name = var.app_sg_name
    }
}
  # Allow port 22 from all
resource "aws_vpc_security_group_ingress_rule" "allow_22"{
    security_group_id = aws_security_group.allow_ssh_http_3000.id
    ip_protocol = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_ipv4   = "0.0.0.0/0"
}
  # Allow port 80 from all
resource "aws_vpc_security_group_ingress_rule" "allow_80"{
    security_group_id = aws_security_group.allow_ssh_http_3000.id
    ip_protocol = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_ipv4   = "0.0.0.0/0"
}
  # Allow port 3000 from all
resource "aws_vpc_security_group_ingress_rule" "allow_3000"{
    security_group_id = aws_security_group.allow_ssh_http_3000.id
    ip_protocol = "tcp"
    from_port   = 3000
    to_port     = 3000
    cidr_ipv4   = "0.0.0.0/0"
}
  # Allow all out
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_ssh_http_3000.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
