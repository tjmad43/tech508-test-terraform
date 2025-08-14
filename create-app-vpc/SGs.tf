# database security group 

resource "aws_security_group" "allow_27017" {
  name        = var.db_sg_name
  description = var.db_sg_name
  vpc_id      = aws_vpc.main.id

    tags = {
    Name = var.db_sg_name
    }
}
  # Allow port 27017 from all
resource "aws_vpc_security_group_ingress_rule" "allow_27017"{
    security_group_id = aws_security_group.allow_27017.id
    ip_protocol = "tcp"
    from_port   = 27017
    to_port     = 27017
    cidr_ipv4   = "0.0.0.0/0"
}
  # Allow all out
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_27017.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
# resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
#   security_group_id = aws_security_group.allow_27017.id
#   cidr_ipv6         = "::/0"
#   ip_protocol       = "-1" # semantically equivalent to all ports
# }


# app security group

resource "aws_security_group" "allow_22_3000_80" {
  name        = var.app_sg_name
  description = var.app_sg_name
  vpc_id      = aws_vpc.main.id

    tags = {
    Name = var.app_sg_name
    }
}
  # Allow port 22 from localhost
resource "aws_vpc_security_group_ingress_rule" "allow_ssh"{
    security_group_id = aws_security_group.allow_22_3000_80.id
    ip_protocol = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_ipv4   = local.my_public_ip_cidr
}
  # Allow port 3000 from all
resource "aws_vpc_security_group_ingress_rule" "allow_3000"{
    security_group_id = aws_security_group.allow_22_3000_80.id
    ip_protocol = "tcp"
    from_port   = 3000
    to_port     = 3000
    cidr_ipv4   = "0.0.0.0/0"
}
  # Allow HTTP from all
resource "aws_vpc_security_group_ingress_rule" "allow_http"{
    security_group_id = aws_security_group.allow_22_3000_80.id
    ip_protocol = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_ipv4   = "0.0.0.0/0"
}
  # Allow all out
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4_app" {
  security_group_id = aws_security_group.allow_22_3000_80.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
  security_group_id = aws_security_group.allow_22_3000_80.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

