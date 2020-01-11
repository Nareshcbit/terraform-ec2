
resource "aws_instance" "server" {

  count = var.instance_count

  ami                       = "${data.aws_ami.latest-ubuntu.id}"
  instance_type             = var.instance_type
  subnet_id                 = var.subnet_id
  vpc_security_group_ids    = var.security_group_ids



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
