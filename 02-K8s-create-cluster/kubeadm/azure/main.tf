variable "group_name" {
  type = string
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

resource "random_id" "value" {
  byte_length = 3
}

locals {
  template_file_int = templatefile("./install_docker_kubectl.tpl", {})
}

resource "azurerm_resource_group" "example" {
  name     = "${var.group_name}-rg-${random_id.value.id}"
  location = "westus3"
}

module "linuxservers" {
  source              = "Azure/compute/azurerm"
  resource_group_name = azurerm_resource_group.example.name
  vm_os_simple        = "UbuntuServer"
  nb_instances        =  var.num_instances
  nb_public_ip        =  var.num_instances
  #public_ip_dns       = ["linsimplevmips"] // change to a unique name per datacenter region
  vnet_subnet_id       = module.network.vnet_subnets[0]
  storage_account_type = "Standard_LRS"
  remote_port          = "22"
  custom_data          = local.template_file_int
  enable_ssh_key       = true
  ssh_key              = "mykey.pub"
  delete_os_disk_on_termination = "true"
  admin_password = "test123"

  depends_on = [azurerm_resource_group.example]
}

module "network" {
  source              = "Azure/network/azurerm"
  resource_group_name = azurerm_resource_group.example.name
  subnet_prefixes     = ["10.0.1.0/24"]
  subnet_names        = ["subnet1"]

  depends_on = [azurerm_resource_group.example]
}

resource "azurerm_network_security_rule" "web" {
  name                        = "allow_remote_web_traffic"
  resource_group_name         = azurerm_resource_group.example.name
  description                 = "Allow web traffic"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["80", "8000-8090"]
  source_address_prefixes     = ["0.0.0.0/0"]
  destination_address_prefix  = "*"
  network_security_group_name = "myvm-nsg"

  depends_on = [module.linuxservers.azurerm_network_security_group]
}

output "linux_vm_public_name" {
  value = module.linuxservers.*.public_ip_address
}
