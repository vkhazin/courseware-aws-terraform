resource "tls_private_key" "ssh-key" {
    algorithm = "RSA"
    rsa_bits = 4096
}

resource "local_file" "foo" {
    content             = tls_private_key.ssh-key.private_key_pem
    filename            = "./${var.key_name}.pem"
    file_permission     = "400"
}

resource "aws_key_pair" "ssh-key-pair" {
    key_name = var.key_name
    public_key = tls_private_key.ssh-key.public_key_openssh
}

resource "aws_security_group" "sg" {
    name = "Dev Security Group"
    description = "Allow SSH inbound traffic"
    vpc_id = aws_vpc.vpc.id
}

resource "aws_security_group_rule" "ssh_inbound_access" {
    from_port = 22
    protocol = "tcp"
    security_group_id = aws_security_group.sg.id
    to_port = 22
    type = "ingress"
    cidr_blocks = [
        "0.0.0.0/0"
    ]
}