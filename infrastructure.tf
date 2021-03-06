variable "puppet_master_name" {
  description = "The fqdn of the puppet master"
  default = "puppet.infrastructure.lab"
}

variable "puppet_master_ip" {
  description = "The IP address of the puppet master"
  default = "192.168.1.10"
}


module "base_network" {
  source = "./networking"
}

module "puppet_master" {
  source = "./puppet_master"

  control_repo         = "${var.puppet_control_repo}"
  ssh_pri_key          = "${var.ssh_private_key}"
  ssh_pub_key          = "${var.ssh_public_key}"
}

module "jenkins_master" {
  source = "./linux_node"

  name = "jenkins01"
  role = "jenkins_master"
  location = "infrastructure"
  puppet_master_name = "${var.puppet_master_name}"
  puppet_master_ip = "${var.puppet_master_ip}"
}

module "fileserver" {
  source = "./linux_node"

  name = "fileserver"
  role = "fileserver"
  location = "infrastructure"
  puppet_master_name = "${var.puppet_master_name}"
  puppet_master_ip = "${var.puppet_master_ip}"
}

module "gitlab" {
  source = "./linux_large_node"

  name = "gitlab"
  role = "gitlab"
  location = "infrastructure"
  puppet_master_name = "${var.puppet_master_name}"
  puppet_master_ip = "${var.puppet_master_ip}"
}

module "linuxnode01" {
  source = "./linux_node"

  name = "linuxnode01"
  role = "generic_website"
  location = "chicago"
  tenant_network = "chicago_network"
  puppet_master_name = "${var.puppet_master_name}"
  puppet_master_ip = "${var.puppet_master_ip}"
}

module "linuxnode02" {
  source = "./linux_node"

  name = "linuxnode02"
  role = "generic_website"
  location = "portland"
  tenant_network = "portland_network"
  puppet_master_name = "${var.puppet_master_name}"
  puppet_master_ip = "${var.puppet_master_ip}"
}

/*
module "testnode01" {
  source = "./linux_node"

  name = "testnode01"
  role = "testnode"
  location = "infrastructure"
  puppet_master_name = "${var.puppet_master_name}"
  puppet_master_ip = "${var.puppet_master_ip}"
}

module "consul01" {
  source = "./linux_node"

  name = "consul01"
  role = "consul"
  location = "infrastructure"
  tenant_network = "infrastructure_network"
  puppet_master_name = "${var.puppet_master_name}"
  puppet_master_ip = "${var.puppet_master_ip}"
}

module "consul02" {
  source = "./linux_node"

  name = "consul02"
  role = "consul"
  location = "infrastructure"
  tenant_network = "infrastructure_network"
  puppet_master_name = "${var.puppet_master_name}"
  puppet_master_ip = "${var.puppet_master_ip}"
}

module "consul03" {
  source = "./linux_node"

  name = "consul03"
  role = "consul"
  location = "infrastructure"
  tenant_network = "infrastructure_network"
  puppet_master_name = "${var.puppet_master_name}"
  puppet_master_ip = "${var.puppet_master_ip}"
}

*/
module "sonarqube" {
  source = "./linux_large_node"

  name = "sonarqube"
  role = "sonarqube"
  location = "infrastructure"
  puppet_master_name = "${var.puppet_master_name}"
  puppet_master_ip = "${var.puppet_master_ip}"
}

module "icinga" {
  source = "./linux_node"

  name = "icinga"
  role = "icinga_server"
  location = "infrastructure"
  puppet_master_name = "${var.puppet_master_name}"
  puppet_master_ip = "${var.puppet_master_ip}"
}

module "windows01" {
  source = "./windows_node"

  name = "windows01"
  role = "generic_website"
  location = "chicago"
  tenant_network = "chicago_network"
  puppet_master_name = "${var.puppet_master_name}"
  puppet_master_ip = "${var.puppet_master_ip}"
}

module "windows02" {
  source = "./windows_node"

  name = "windows02"
  role = "generic_website"
  location = "portland"
  tenant_network = "portland_network"
  puppet_master_name = "${var.puppet_master_name}"
  puppet_master_ip = "${var.puppet_master_ip}"
}

/*
module "windows03" {
  source = "./windows_node"

  name = "windows03"
  role = "generic_website"
  location = "chicago"
  tenant_network = "chicago_network"
  puppet_master_name = "${var.puppet_master_name}"
  puppet_master_ip = "${var.puppet_master_ip}"
}

module "windows04" {
  source = "./windows_node"

  name = "windows04"
  role = "generic_website"
  location = "portland"
  tenant_network = "portland_network"
  puppet_master_name = "${var.puppet_master_name}"
  puppet_master_ip = "${var.puppet_master_ip}"
}

*/
module "windows-test" {
  source = "./windows_node"

  name = "windows-test"
  role = "active_directory"
  location = "portland"
  tenant_network = "portland_network"
  puppet_master_name = "${var.puppet_master_name}"
  puppet_master_ip = "${var.puppet_master_ip}"
}
