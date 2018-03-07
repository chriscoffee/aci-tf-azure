import unittest
from runner import Runner


class TestE2E(unittest.TestCase):
  @classmethod
  def setUpClass(self):
    self.snippet = """

            provider "azurerm" {
              subscription_id = "null"
              client_id = "null"
              client_secret = "null"
              tenant_id = "null"
              skip_credentials_validation = true
            }

            module "aci" {
              source = "./mymodule"

              resource_group =  {
                  name = "aciresourcegroup"
              }

              location = "West Europe"

              storage_account {
                  name = "acistorageaccount"
                  account_tier = "Standard"
                  account_replication_type = "LRS"
              }

              storage_share {
                  name = "acistorageshare"
                  quota = "50"
              }

              container_group {
                  name = "acicontainergroup"
                  ip_address_type = "public"
                  os_type = "linux"
              }

              container {
                  name = "acicontainer"
                  image = "library/helloworld:latest"
                  cpu = "0.5"
                  memory = "1.5"
                  port = "1234"
              }

              command = "/bin/bash -c 'printenv'"

              environment = "local"
            }
        """
    self.result = Runner(self.snippet).result

  def test_root_destroy(self):
    self.assertEqual(self.result["destroy"], False)
    self.assertEqual(self.result["aci"]["destroy"], False)

  def test_azurerm_resource_group_name(self):
    self.assertEqual("aciresourcegroup", self.result["aci"]["azurerm_resource_group.aci_rg"]["name"])

  def test_azurerm_storage_account_name(self):
    self.assertEqual("acistorageaccount", self.result["aci"]["azurerm_storage_account.aci_sa"]["name"])

  def test_azurerm_storage_share_name(self):
    self.assertEqual("acistorageshare", self.result["aci"]["azurerm_storage_share.aci_ss"]["name"])

  def test_azurerm_container_group_name(self):
    self.assertEqual("acicontainergroup", self.result["aci"]["azurerm_container_group.aci_cg"]["name"])

if __name__ == '__main__':
  unittest.main()
