provider "aws" {
  alias  = "south"
  region = "ap-south-1"
}

 resource "aws_instance" "demo-server" {
  ami           = "ami-013e83f579886baeb"
  instance_type = "t2.micro"
  key_name     = "dpp-keypair"
  security_groups = [ "allow_tls" ]
 }

 resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "SSH Access"
  #vpc_id      = aws_vpc.main.id

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}


resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  from_port         = 22
  to_port           = 22
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

