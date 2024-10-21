provider "azurerm" {
  features {}
  subscription_id = "ac08f0b0-e258-491e-802e-eb2b78eebb46"  # Reemplaza esto con tu ID de suscripción
}

resource "azurerm_resource_group" "rg" {
   name = "rg-${var.project}-${var.environment}"
    location = var.location

  tags = var.tags
}
