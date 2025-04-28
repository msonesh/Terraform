# provider "azurerm" {
#   features {}
#   subscription_id = "c214e6c4-51a0-4409-90ba-e1e4ac5d4ede"

resource "azurerm_public_ip" "frontend" {
  name                = "frontend"
  resource_group_name = "RG-Test"
  location            = "UK West"
  allocation_method   = "Static"


}
resource "azurerm_network_interface" "frontend" {
  name                = "frontend-nic"
  location            = "UK West"
  resource_group_name = "RG-Test"

  ip_configuration {
    name                          = "frontend-nic"
    subnet_id                     = "/subscriptions/c214e6c4-51a0-4409-90ba-e1e4ac5d4ede/resourceGroups/RG-Test/providers/Microsoft.Network/virtualNetworks/devops-vn/subnets/default"
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_virtual_machine" "frontend" {
  name                  = "frontend-vm"
  location              = "UK West"
  resource_group_name   = "RG-Test"
  network_interface_ids = [azurerm_network_interface.frontend.id]
  vm_size               = "Standard_B2s"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_image_reference {
    id   = "/subscriptions/c214e6c4-51a0-4409-90ba-e1e4ac5d4ede/resourceGroups/RG-Test/providers/Microsoft.Compute/images/image-test"
  }
  storage_os_disk {
    name              = "frontend-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "frontend"
    admin_username = "azureuser"
    admin_password = "Devsecops@2020"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}