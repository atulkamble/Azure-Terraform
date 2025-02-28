Here are some **Terraform practice codes for Azure**, covering essential infrastructure components. These examples will help you practice deploying resources using Terraform.

---

## **1. Basic Azure Resource Group**
This code creates a **Resource Group** in Azure.

```hcl
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "rg-example"
  location = "East US"
}

output "resource_group_name" {
  value = azurerm_resource_group.example.name
}
```

---

## **2. Deploy a Virtual Network (VNet)**
This creates a **VNet with a subnet**.

```hcl
resource "azurerm_virtual_network" "example" {
  name                = "vnet-example"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "example" {
  name                 = "subnet-example"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
}

output "subnet_id" {
  value = azurerm_subnet.example.id
}
```

---

## **3. Deploy an Azure Virtual Machine (Linux)**
This deploys an **Ubuntu VM with SSH access**.

```hcl
resource "azurerm_network_interface" "example" {
  name                = "nic-example"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.example.id
  }
}

resource "azurerm_public_ip" "example" {
  name                = "public-ip-example"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  allocation_method   = "Dynamic"
}

resource "azurerm_virtual_machine" "example" {
  name                  = "vm-example"
  location              = azurerm_resource_group.example.location
  resource_group_name   = azurerm_resource_group.example.name
  network_interface_ids = [azurerm_network_interface.example.id]
  vm_size               = "Standard_B1s"

  storage_os_disk {
    name              = "osdisk-example"
    caching          = "ReadWrite"
    create_option    = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = "examplevm"
    admin_username = "azureuser"
    admin_password = "P@ssw0rd123!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}
```

---

## **4. Create an Azure Storage Account**
This code sets up an **Azure Storage Account**.

```hcl
resource "azurerm_storage_account" "example" {
  name                     = "examplestoraccount"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

output "storage_account_name" {
  value = azurerm_storage_account.example.name
}
```

---

## **5. Deploy an Azure App Service (Web App)**
This deploys an **Azure App Service running on Linux**.

```hcl
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
```

---

## **6. Deploy an Azure Kubernetes Service (AKS) Cluster**
This creates an **Azure Kubernetes Cluster (AKS)**.

```hcl
resource "azurerm_kubernetes_cluster" "example" {
  name                = "aks-cluster-example"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  dns_prefix          = "exampleaks"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_B2s"
  }

  identity {
    type = "SystemAssigned"
  }
}

output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.example.name
}
```

---

These **Terraform codes** cover various **Azure services**. Let me know if you need specific Terraform scripts! 🚀
