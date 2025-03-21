resource "aws_security_group" "firewall" {
  name        = "my-firewall"
  description = "Security group for servers, allowing SSH and database access."
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.firewall.id
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
  description       = "Allow SSH access from any IP"
}

resource "aws_vpc_security_group_ingress_rule" "allow_internal_db" {
  for_each         = { for idx, instance in aws_instance.servers : idx => instance.private_ip }
  security_group_id = aws_security_group.firewall.id
  from_port         = 5432
  to_port           = 5435
  ip_protocol       = "tcp"
  cidr_ipv4         = "${each.value}/32"
  description       = "Allow db access only between servers"
}

resource "aws_vpc_security_group_ingress_rule" "allow_replica_access" {
  security_group_id = aws_security_group.firewall.id
  from_port         = 5432
  to_port           = 5432
  ip_protocol       = "tcp"
  cidr_ipv4         = "${aws_instance.servers[1].private_ip}/32"
  description       = "Allow replica access"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
  security_group_id = aws_security_group.firewall.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
  description       = "Allow all outbound traffic"
}
