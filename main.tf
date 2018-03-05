provider "azurerm" {}
provider "docker" {}

resource "azurerm_resource_group" "aci_rg" {
  name     = "${var.resource_group['name']}"
  location = "${var.location}"
}

resource "azurerm_storage_account" "aci_sa" {
  name                = "${var.storage_account['name']}"
  resource_group_name = "${azurerm_resource_group.aci_rg.name}"
  location            = "${azurerm_resource_group.aci_rg.location}"
  account_tier        = "${var.storage_account['account_tier']}"

  account_replication_type = "${var.storage_account['account_replication_type']}"
}

resource "azurerm_storage_share" "aci_ss" {
  name = "${var.storage_share['name']}"

  resource_group_name  = "${azurerm_resource_group.aci_rg.name}"
  storage_account_name = "${azurerm_storage_account.aci_rg.name}"

  quota = "${var.storage_share['quota']}"
}

resource "azurerm_container_group" "aci-cg" {
  name                = "${var.container_group['name']}"
  location            = "${azurerm_resource_group.aci_rg.location}"
  resource_group_name = "${azurerm_resource_group.aci_rg.name}"
  ip_address_type     = "${var.container_group['ip_address_type']}"
  dns_label_name      = "${var.container_group['dns_label_name']}"
  os_type             = "${var.container_group['os_type']}"

  container {
    name   = "${var.container['name']}"
    image  = "${var.container['image']}"
    cpu    = "${var.container['cpu']}"
    memory =  "${var.container['memory']}"
    port   = "${var.container['port']}"

    environment_variables {
      ["${lookup(var.environment_variables)}"]
    }

    command = "${var.command}"

    volume {
      name       = "logs"
      mount_path = "/aci/logs"
      read_only  = false
      share_name = "${azurerm_storage_share.aci_ss.name}"

      storage_account_name  = "${azurerm_storage_account.aci_sa.name}"
      storage_account_key   = "${azurerm_storage_account.aci_sa.primary_access_key}"
    }
  }

  tags {
    environment = "dev"
    BillingIdentifier = "TIS"
  }
}
