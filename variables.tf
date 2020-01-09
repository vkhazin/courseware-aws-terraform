variable "aws_region" {
    default = "us-east-1"
}

variable "aws_availability_zone" {
  default = "us-east-1a"
}

variable "key_name" {
  default = "courseware-terraform"
}

output "ubuntu_public_ip" {
  value = aws_instance.ubuntu-vm.public_ip
}