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
  location = "East US"
}

resource "azurerm_service_plan" "example" {
  name                = "appserviceplan-example"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_app_service" "example" {
  name                = "webapp-example"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  app_service_plan_id = azurerm_service_plan.example.id

  site_config {
    linux_fx_version = "NODE|14-lts"
  }
}

output "web_app_url" {
  value = azurerm_app_service.example.default_site_hostname
}
