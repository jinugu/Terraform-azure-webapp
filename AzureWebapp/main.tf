# Configure the Azure provider
provider "azurerm" {
  version = "=2.4.0"

  subscription_id = "395b2b6c-8fb6-4cc1-83e4-39455be6b102"
  client_id       = "72b2db2e-be38-456a-90ba-6f56877fc782"
  client_secret   = "pq064c.VJ5_X_a~rwTDKs8In42eQhmmw67"
  tenant_id       = "90c3f360-0a02-49e4-b70c-4ebb69378edf"

  features {}
}

resource "azurerm_resource_group" "webrg2" {
  name     = "webapprg00"
  location = "eastus"
}

resource "azurerm_app_service_plan" "webplan2" {
  name                = "slotAppServicePlan05"
  location            = azurerm_resource_group.webrg2.location
  resource_group_name = azurerm_resource_group.webrg2.name
  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "random_id" "randomId" {
  keepers = {
    # Generate a new ID only when a new resource group is defined
    resource_group = azurerm_resource_group.webrg2.name
  }

  byte_length = 8
}
resource "azurerm_app_service" "webapp2" {
  name                = "slotAppService500${random_id.randomId.hex}"
  location            = azurerm_resource_group.webrg2.location
  resource_group_name = azurerm_resource_group.webrg2.name
  app_service_plan_id = azurerm_app_service_plan.webplan2.id
}

resource "azurerm_app_service_slot" "slotDemo2" {
    name                = "slotAppServiceSlotOne500${random_id.randomId.hex}"
    location            = azurerm_resource_group.webrg2.location
    resource_group_name = azurerm_resource_group.webrg2.name
    app_service_plan_id = azurerm_app_service_plan.webplan2.id
    app_service_name    = azurerm_app_service.webapp2.name
}
