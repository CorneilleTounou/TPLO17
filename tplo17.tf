provider "azurerm" {
  subscription_id = "20c3c832-40df-46b4-984f-64066a82bdb9"
  client_id       = "652768c5-98e0-4b1c-818f-35e2b857d9e8"
  client_secret   = "3vx8Q~s25IImN4YxAKLW5iMk2cKRbQMRh9lquckC"
  tenant_id       = "987b6351-7e5c-42d9-8e61-3830e896b75e"
  features {}
}
### Configure Terraform ---- End ---- ###

### Create Ressource Group ---- Start ---- ###
resource "azurerm_resource_group" "rg" {
name = "RG_ATOUNOU_4"
location = "northeurope"
}

### Create virtual network ---- Start ---- ####
resource "azurerm_virtual_network" "vn4" {
name = "VN-RG4_ATOUNOU_4"
resource_group_name = azurerm_resource_group.rg.name
location = azurerm_resource_group.rg.location
address_space = ["10.2.0.0/16"]
}
### Create virtual network ---- End ---- ####

### Create subnet network ---- Start ---- ###
resource "azurerm_subnet" "subnet4" {
name = "internal"
resource_group_name = azurerm_resource_group.rg.name
virtual_network_name = azurerm_virtual_network.vn4.name
address_prefixes = ["10.2.2.0/24"]
}
### Create subnet network ---- End ---- ###

### Create a public IP ---- Start ---- ###
resource "azurerm_public_ip" "publicip4" {
name = "IP_ATOUNOU_4"
location = azurerm_resource_group.rg.location
resource_group_name = azurerm_resource_group.rg.name
allocation_method = "Dynamic"
}
### Create a public IP ---- End ---- ###

#### Create virtual interface ---- Start ---- ###
resource "azurerm_network_interface" "NI4" {
name = "NI_ATOUNOU_4"
location = azurerm_resource_group.rg.location
resource_group_name = azurerm_resource_group.rg.name
ip_configuration {
name = "VM4NI4Cfg"
subnet_id = azurerm_subnet.subnet4.id
public_ip_address_id = azurerm_public_ip.publicip4.id
private_ip_address_allocation = "Dynamic"
}
}
#### Create virtual interface ---- End ---- ###

### Create Windows VM ---- Start ---- ###
resource "azurerm_virtual_machine" "vm4" {
name = "VM-ATOUNOU-4"
resource_group_name = azurerm_resource_group.rg.name
location = azurerm_resource_group.rg.location
vm_size = "Standard_D2as_v4"
network_interface_ids = [azurerm_network_interface.NI4.id]
storage_image_reference {
publisher = "MicrosoftWindowsServer"
offer = "WindowsServer"
sku = "2019-Datacenter"
version = "latest"
}
storage_os_disk {
create_option = "FromImage"
managed_disk_type = "Standard_LRS"
caching = "ReadWrite"
name = "diskosvm4"
}
os_profile {
computer_name = "CorneilleADT"
admin_username = "SuperCorneille"
admin_password = "281198@Corneille"
}
os_profile_windows_config {
provision_vm_agent = "true"
}
}
### Create Windows VM ---- End ---- ###

### Create virtual network ---- Start ---- ####
resource "azurerm_virtual_network" "vn5" {
name = "VN-RG4_ATOUNOU_5"
resource_group_name = azurerm_resource_group.rg.name
location = azurerm_resource_group.rg.location
address_space = ["10.3.0.0/16"]
}
### Create virtual network ---- End ---- ####

### Create subnet network ---- Start ---- ###
resource "azurerm_subnet" "subnet5" {
name = "vminternal"
resource_group_name = azurerm_resource_group.rg.name
virtual_network_name = azurerm_virtual_network.vn5.name
address_prefixes = ["10.3.2.0/24"]
}
### Create subnet network ---- End ---- ###

### Create a public IP ---- Start ---- ###
resource "azurerm_public_ip" "publicip5" {
name = "IP_ATOUNOU_5"
location = azurerm_resource_group.rg.location
resource_group_name = azurerm_resource_group.rg.name
allocation_method = "Dynamic"
}
### Create a public IP ---- End ---- ###

#### Create virtual interface ---- Start ---- ###
resource "azurerm_network_interface" "NI5" {
name = "NI_ATOUNOU_5"
location = azurerm_resource_group.rg.location
resource_group_name = azurerm_resource_group.rg.name
ip_configuration {
name = "VM5NI5Cfg"
subnet_id = azurerm_subnet.subnet5.id
public_ip_address_id = azurerm_public_ip.publicip5.id
private_ip_address_allocation = "Dynamic"
}
}
#### Create virtual interface ---- End ---- ###

### Create Windows VM ---- Start ---- ###
resource "azurerm_virtual_machine" "vm5" {
name = "VM-ATOUNOU-5"
resource_group_name = azurerm_resource_group.rg.name
location = azurerm_resource_group.rg.location
vm_size = "Standard_D2as_v4"
network_interface_ids = [azurerm_network_interface.NI5.id]
storage_image_reference {
publisher = "MicrosoftWindowsServer"
offer = "WindowsServer"
sku = "2019-Datacenter"
version = "latest"
}
storage_os_disk {
create_option = "FromImage"
managed_disk_type = "Standard_LRS"
caching = "ReadWrite"
name = "diskosvm5"
}
os_profile {
computer_name = "CorneilleADT2"
admin_username = "SuperCorneille2"
admin_password = "281198@Corneille"
}
os_profile_windows_config {
provision_vm_agent = "true"
}
}
### Create Windows VM ---- End ---- ###
