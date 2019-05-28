variable "common_name" {
  type = "string"
}

variable "key_name" {
  type = "string"
}

variable "ami" {
  type = "string"
}

variable "instance_count" {
  default = 1
}

variable "associate_public_ip_address" {
  default = true
}

variable "iam_instnace_policy" {
  type    = "string"
  default = ""
}

variable "root_disk_size" {
  default = 40
}

variable "vpc_security_group_ids" {
  type    = "list"
  default = []
}

variable "subnet_ids" {
  type    = "list"
  default = []
}

variable "name_array" {
  type    = "list"
  default = []
}

variable "instance_type" {
  type    = "string"
  default = "t2.medium"
}

variable "admin_pass" {
  type    = "string"
  default = ""
}

variable "chef_user" {
  type    = "string"
  default = "chef"
}

variable "chef_pass" {
  type    = "string"
  default = "P@55w0rd1"
}

variable "install_hab" {
  default = true
}

variable "hab_version" {
  type    = "string"
  default = ""
}

variable "docker_image_name" {
  type    = "string"
  default = ""
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  default     = {}
}
