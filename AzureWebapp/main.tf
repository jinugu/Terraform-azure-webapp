provider "azurerm" {
   version = "=2.4.0"

  subscription_id = "5d3413ed-dbd0-41ad-b6a8-590c53fb98b5"
  client_id       = "82686256-2a67-4f64-9fdd-02b95a7ede9d"
  client_secret   = "nmZ7Q~73Bt7fiDw4UXYtVLbhVeCNK.Su18xCD"
  tenant_id       = "ee44799a-b251-446f-81eb-00afeef901c5"

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
