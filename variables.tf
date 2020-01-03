variable "region" {

    type = "string"
    default = "ap-south-1"

}

variable "instance_ami" {

  type = "string"
  default = "ami-02913db388613c3e1"

}

variable "instance_type" {

  type = "string"
  default = "t2.micro"
}

variable "instance_name"{
  default = "web"
}

variable "instance_count"{
  default = 2
}
