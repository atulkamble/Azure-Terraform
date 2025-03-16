terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "cc57cd42-dede-4674-b810-a0fbde41504a"
}

resource "azurerm_resource_group" "example" {
  name     = "example-resource-group"
  location = "West US" # Changed from East US to West US
}

resource "azurerm_service_plan" "example" {
  name                = "appserviceplan-example"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  os_type             = "Linux"
  sku_name            = "F1" # Changed from B1 to F1
}

resource "azurerm_app_service" "example" {
  name                = "webapp-example-902828"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  app_service_plan_id = azurerm_service_plan.example.id

  site_config {
    linux_fx_version = "NODE|14-lts"
  }

  depends_on = [azurerm_service_plan.example, azurerm_resource_group.example] # Ensure dependencies are created first
}

output "web_app_url" {
  value = azurerm_app_service.example.default_site_hostname
}
