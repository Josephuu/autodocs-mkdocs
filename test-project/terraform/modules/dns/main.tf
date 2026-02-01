# DNS Module for Azure
# Creates DNS zones and records

resource "azurerm_dns_zone" "this" {
  name                = var.zone_name
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_dns_a_record" "root" {
  name                = "@"
  zone_name           = azurerm_dns_zone.this.name
  resource_group_name = var.resource_group_name
  ttl                 = var.ttl
  records             = [var.root_ip]
}

resource "azurerm_dns_cname_record" "www" {
  name                = "www"
  zone_name           = azurerm_dns_zone.this.name
  resource_group_name = var.resource_group_name
  ttl                 = var.ttl
  record              = var.zone_name
}
