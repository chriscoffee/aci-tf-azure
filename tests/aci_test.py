import unittest
from runner import Runner


class TestE2E(unittest.TestCase):
    @classmethod
    def setUpClass(self):
        self.snippet = """
            provider "azurerm" {
              environment = "public"
              skip_credentials_validation = true
              skip_provider_registration = true
            }
            module "aci" {
              source = "./mymodule"
              providers = {
                azurerm = "azurerm"
              }

              resource_group =  {
                  name = "aci-test"
              }   
              location = "west-europe"
              storage_account {
                  name = "aci-storage-account"
                  account_tier = "Standard"
                  account_replication_type = "LRS"
              }
              storage_share {
                  name = "aci-storage-share"
                  quota = 50
              }
              container_group {
                  name = "aci-container-group"
                  ip_address_type = "public"
                  dns_label_name = "aci-label"
                  os_type = "linux"
              }
              container {
                  name = "aci-container"
                  image = "library/helloworld:latest"
                  cpu = "0.5"
                  memory "1.5"
                  port = "1234"
              }
              environment_variables {
                  "NODE_ENV" = "test" 
                  "DOULYKMUDKIPS" = "yes"
              }
              command = "/bin/bash -c './testymctesterson.sh'"
              environment = local
            }
        """
        self.result = Runner(self.snippet).result

    def test_root_destroy(self):
        self.assertEqual(self.result["destroy"], False)

# TODO: Write some further tests

if __name__ == '__main__':
    unittest.main()