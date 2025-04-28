provider "azurerm" {
   features {}
}

resource "azurerm_virtual_machine" "devops" {
  name                  = "devops-vm"
  location              = "UK West"
  resource_group_name   = "RG-Test"
  network_interface_ids = ["/subscriptions/c214e6c4-51a0-4409-90ba-e1e4ac5d4ede/resourceGroups/RG-Test/providers/Microsoft.Network/networkInterfaces/devops-ni"]
  vm_size               = "Standard D2s v3"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_image_reference {
    id   = "/subscriptions/c214e6c4-51a0-4409-90ba-e1e4ac5d4ede/resourceGroups/RG-Test/providers/Microsoft.Compute/virtualMachines/image"
  }
  storage_os_disk {
    name              = "devops-vm"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "devops-vm"
    admin_username = "azureuser"
    admin_password = "Devsecops@2020"
  }

}