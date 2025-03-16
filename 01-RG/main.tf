provider "azurerm" {
  features {}
  subscription_id = "cc57cd42-dede-4674-b810-a0fbde41504a"
}

resource "azurerm_resource_group" "example" {
  name     = "RG-Atul"
  location = "East US"
}

output "resource_group_name" {
  value = azurerm_resource_group.example.name
}
