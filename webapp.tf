resource "azurerm_app_service_plan" "app_service_plan" {
  name                = "asp-${var.project}-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Standard"
    size = "B1"
  }

  tags = var.tags
}

resource "azurerm_container_registry" "acr" {
  name                = "acr${var.project}${var.environment}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  sku                 = "Basic"
  admin_enabled       = true

  tags = var.tags
}

resource "azurerm_app_service" "webapp_ui" {
  name                = "ui-${var.project}-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.app_service_plan.id

  site_config {
    linux_fx_version      = "DOCKER|${azurerm_container_registry.acr.login_server}/${var.project}/ui:latest"
    always_on             = true
    vnet_route_all_enabled = true
  }

  app_settings = {
    "DOCKER_REGISTRY_SERVER_URL"      = "https://${azurerm_container_registry.acr.login_server}"
    "DOCKER_REGISTRY_SERVER_USERNAME" = azurerm_container_registry.acr.admin_username
    "DOCKER_REGISTRY_SERVER_PASSWORD" = azurerm_container_registry.acr.admin_password
    "WEBSITE_VNET_ROUTE_ALL"          = "1"
  }

  depends_on = [
    azurerm_app_service_plan.app_service_plan,
    azurerm_container_registry.acr,
    azurerm_subnet.subnetweb
  ]

  tags = var.tags
}

resource "azurerm_app_service_virtual_network_swift_connection" "webapp_ui_vnet_integration" {
  app_service_id = azurerm_app_service.webapp_ui.id
  subnet_id      = azurerm_subnet.subnetweb.id

  depends_on = [
    azurerm_app_service.webapp_ui
  ]
}

resource "azurerm_app_service" "webapp_api" {
  name                = "api-${var.project}-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.app_service_plan.id

  site_config {
    linux_fx_version      = "DOCKER|${azurerm_container_registry.acr.login_server}/${var.project}/api:latest"
    always_on             = true
    vnet_route_all_enabled = true
  }

  app_settings = {
    "DOCKER_REGISTRY_SERVER_URL"      = "https://${azurerm_container_registry.acr.login_server}"
    "DOCKER_REGISTRY_SERVER_USERNAME" = azurerm_container_registry.acr.admin_username
    "DOCKER_REGISTRY_SERVER_PASSWORD" = azurerm_container_registry.acr.admin_password
    "WEBSITE_VNET_ROUTE_ALL"          = "1"
  }

  depends_on = [
    azurerm_app_service_plan.app_service_plan,
    azurerm_container_registry.acr,
    azurerm_subnet.subnetweb
  ]

  tags = var.tags
}

resource "azurerm_app_service_virtual_network_swift_connection" "webapp_api_vnet_integration" {
  app_service_id = azurerm_app_service.webapp_api.id
  subnet_id      = azurerm_subnet.subnetweb.id

  depends_on = [
    azurerm_app_service.webapp_api
  ]
}

# Backoffice SErvice Plan
resource "azurerm_app_service_plan" "app_service_plan_backoffice" {
  name                = "asp-backoffice-${var.project}-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Standard"
    size = "B1"
  }

  tags = var.tags
}

resource "azurerm_app_service" "backoffice_ui" {
  name                = "backoffice-ui-${var.project}-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.app_service_plan_backoffice.id

  site_config {
    linux_fx_version      = "DOCKER|${azurerm_container_registry.acr.login_server}/${var.project}/backoffice-ui:latest"
    always_on             = true
    vnet_route_all_enabled = true
  }

  app_settings = {
    "DOCKER_REGISTRY_SERVER_URL"      = "https://${azurerm_container_registry.acr.login_server}"
    "DOCKER_REGISTRY_SERVER_USERNAME" = azurerm_container_registry.acr.admin_username
    "DOCKER_REGISTRY_SERVER_PASSWORD" = azurerm_container_registry.acr.admin_password
    "WEBSITE_VNET_ROUTE_ALL"          = "1"
  }

  depends_on = [
    azurerm_app_service_plan.app_service_plan_backoffice,
    azurerm_container_registry.acr,
    azurerm_subnet.subnet_backoffice
  ]

  tags = var.tags
}

resource "azurerm_app_service_virtual_network_swift_connection" "backoffice_ui_vnet_integration" {
  app_service_id = azurerm_app_service.backoffice_ui.id
  subnet_id      = azurerm_subnet.subnet_backoffice.id

  depends_on = [
    azurerm_app_service.backoffice_ui
  ]
}

resource "azurerm_app_service" "backoffice_api" {
  name                = "backoffice-api-${var.project}-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.app_service_plan_backoffice.id

  site_config {
    linux_fx_version      = "DOCKER|${azurerm_container_registry.acr.login_server}/${var.project}/backoffice-api:latest"
    always_on             = true
    vnet_route_all_enabled = true
  }

  app_settings = {
    "DOCKER_REGISTRY_SERVER_URL"      = "https://${azurerm_container_registry.acr.login_server}"
    "DOCKER_REGISTRY_SERVER_USERNAME" = azurerm_container_registry.acr.admin_username
    "DOCKER_REGISTRY_SERVER_PASSWORD" = azurerm_container_registry.acr.admin_password
    "WEBSITE_VNET_ROUTE_ALL"          = "1"
  }

  depends_on = [
    azurerm_app_service_plan.app_service_plan_backoffice,
    azurerm_container_registry.acr,
    azurerm_subnet.subnet_backoffice
  ]

  tags = var.tags
}

resource "azurerm_app_service_virtual_network_swift_connection" "backoffice_api_vnet_integration" {
  app_service_id = azurerm_app_service.backoffice_api.id
  subnet_id      = azurerm_subnet.subnet_backoffice.id

  depends_on = [
    azurerm_app_service.backoffice_api
  ]
}
