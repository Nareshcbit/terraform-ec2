variable "region" {

    type = "string"
    default = "ap-south-1"

}

variable "ami" {}
variable "subnet_id" {}
variable "security_group_ids" {
  type    = list(string)
  default = []
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
  default = "server"
}

variable "instance_count"{
  default = 1
}

variable "auto_delete" { default = "Yes"}
variable "owner" { default = "Naresh Madiraju"}

variable "common_tags" {
    type = "map"
    default = {
        business_unit = "corp"
        department =  "cloud-engineering",
        team = "cloud-engineering",
        cost_center ="100786",
        app = "reporting-cto",
        env = "development",
        maintenance_window = "Friday 03:00 AM - Friday 05:00 AM",
        auto_approvals = "CORP, COSTOP"
  }
}


variable "global_tags" {
    type = "map"
    default = {
        business_unit = "corp"
        department =  "cloud-engineering",
        team = "cloud-engineering",
        cost_center ="100786",
  }
}

variable "app_tags" {
    type = "map"
    default = {
        app = "reporting-cto",
        env = "development"
  }
}

variable "opt_tags" {
    type = "map"
    default = {
        maintenance_window = "Friday 03:00 AM - Friday 05:00 AM",
        auto_approvals = "CORP, COSTOP"
  }
}
