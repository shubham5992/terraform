resource "azurerm_service_plan" "appwebservicelan" {
  name                = "companyweb"
  resource_group_name = local.resource_group_name 
  location            = local.location
  sku_name            = "B1"
  os_type             = "Windows"
  depends_on = [ azurerm_resource_group.st-rg ]
}


resource "azurerm_windows_web_app" "comanywebapp234" {
  name                = "comanywebapp234"
  resource_group_name = local.resource_group_name
  location            = local.location
  service_plan_id     = azurerm_service_plan.appwebservicelan.id

  site_config {

    application_stack {
      current_stack = "dotnet"
      dotnet_version = "v6.0"
    }
  }
  depends_on = [ azurerm_service_plan.appwebservicelan]
}

