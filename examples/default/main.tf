resource "random_id" "rg_name" {
  byte_length = 8
}

resource "random_password" "password" {
  length = 8
}

resource "azurerm_resource_group" "test" {
  location = var.location
  name     = "testRG-${random_id.rg_name.hex}"
}

module "postgresql" {
  source = "../../"

  resource_group_name = azurerm_resource_group.test.name
  location            = azurerm_resource_group.test.location

  server_name            = "test-server-postgresql"
  administrator_login    = "login"
  administrator_password = random_password.password.result
}