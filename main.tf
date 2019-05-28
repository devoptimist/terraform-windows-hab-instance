data "template_file" "bootstrap" {
  template = "${file("${path.module}/templates/bootstrap.ps1")}"

  vars {
    user              = "${var.chef_user}",
    pass              = "${var.chef_pass}",
    docker_image_name = "${var.docker_image_name}",
    admin_pass        = "$[var.admin_pass}",
    install_hab       = "${var.install_hab}",
    hab_version       = "${var.hab_version}"
  }
}

module "hab-instance" {
  source                      = "devoptimist/ec2-instance/aws"
  version                     = "1.21.0"

  name                        = "${var.common_name}-hab-instance"
  name_array                  = "${var.name_array}"
  instance_count              = "${var.instance_count}"
  associate_public_ip_address = "${var.associate_public_ip_address}"
  iam_instance_profile        = "${var.iam_instnace_policy}"
  ami                         = "${var.ami}"
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.key_name}"
  monitoring                  = true
  vpc_security_group_ids      = "${var.vpc_security_group_ids}"
  subnet_ids                  = "${var.subnet_ids}"

  root_block_device = [{
    volume_type = "gp2"
    volume_size = "${var.root_disk_size}"
  }]

  tags                        = "${var.tags}"
  user_data                   = "${data.template_file.bootstrap.rendered}"
}
