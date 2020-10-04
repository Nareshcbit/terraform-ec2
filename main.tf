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

  ami                       = var.ami
  instance_type             = var.instance_type
  subnet_id                 = var.subnet_id
  vpc_security_group_ids    = var.security_group_ids



  tags = "${merge(
    var.common_tags,
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
