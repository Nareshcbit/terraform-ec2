provider "aws"{

  region = var.region

}

terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket         = "terraform-nxgcloud-infra-development"
    key            = "global/infra/ec2.tfstate"
    region         = "ap-south-1"
  }
}


resource "aws_instance" "server" {

  count = var.instance_count

  ami                       = "${data.aws_ami.latest-ubuntu.id}"
  instance_type             = var.instance_type
  subnet_id                 = var.subnet_id

  #subnet_id                 = "subnet-03b9ccfcca3b1e63e"
  #vpc_security_group_ids     = ["sg-09a7330da211e9df7"]


  tags = "${merge(
    var.global_tags,
    var.app_tags,
    var.opt_tags,
    map(
      "Name", "${var.instance_name}-${count.index}",
      "autodelete", var.auto_delete,
      "owner",var.owner
    )
  )}"

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
