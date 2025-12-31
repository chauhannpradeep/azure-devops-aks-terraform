resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Minimized log cost
resource "azurerm_log_analytics_workspace" "law" {
  name                = "law-aks-devops"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

# Basic ACR (Free-credit optimized)
resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  sku                 = "Basic"
  admin_enabled       = true
}

# AKS (Free-credit optimized)
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_cluster_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "aksdevops"

  default_node_pool {
    name       = "system"
    node_count = var.node_count
    vm_size    = var.node_vm_size
  }

  identity {
    type = "SystemAssigned"
  }

  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id
  }

  tags = {
    environment = "dev"
    project     = "devops-aks-demo"
    cost_center = "free-credits"
  }
}