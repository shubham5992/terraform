resource "azurerm_storage_account" "webstorageaccount" {
  name                     = "storageaccountweb"
  resource_group_name      = local.resource_group_name
  location                 = local.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

 depends_on = [ azurerm_resource_group.st-rg ]
}

resource "azurerm_storage_container" "logs" {
  name                  = "logs"
  storage_account_name  = azurerm_storage_account.webstorageaccount.name
  container_access_type = "blob"

  depends_on = [ azurerm_storage_account.webstorageaccount ]
}

data "azurerm_storage_account_blob_container_sas" "accountsas" {
  connection_string = azurerm_storage_account.webstorageaccount.primary_connection_string
  container_name    = azurerm_storage_container.logs.name
  https_only        = true

  ip_address = "168.1.5.65"

  start  = "2023-03-21"
  expiry = "2023-12-21"

  permissions {
    read   = true
    add    = true
    create = false
    write  = true
    delete = true
    list   = true
  }
  depends_on = [ azurerm_storage_account.webstorageaccount ]
  }