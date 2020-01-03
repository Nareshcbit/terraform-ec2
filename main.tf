provider "aws"{

  region = var.region

}


resource "aws_instance" "server" {

  count = var.instance_count

  ami           = "${data.aws_ami.latest-ubuntu.id}"
  instance_type = var.instance_type

  tags = {
    Name = "${var.instance_name}-${count.index}"
  }

  lifecycle {
    ignore_changes = [
      tags["Name"],ami,
    ]
  }
}


data "aws_ami" "latest-ubuntu" {
most_recent = true
owners = ["099720109477"] # Canonical

  filter {
      name   = "name"
      values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
      name   = "virtualization-type"
      values = ["hvm"]
  }
}


output "image_id" {
    value = "${data.aws_ami.latest-ubuntu.id}"
}
