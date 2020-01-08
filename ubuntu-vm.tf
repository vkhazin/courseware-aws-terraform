data "aws_ami" "instance_ami" {
  most_recent = true
  owners      = [
    "099720109477"
  ]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

resource "aws_instance" "ubuntu-vm" {
  ami                         = data.aws_ami.instance_ami.id
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.public-subnet.id
  vpc_security_group_ids      = [
    aws_security_group.sg.id
  ]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.ssh-key-pair.key_name
}
