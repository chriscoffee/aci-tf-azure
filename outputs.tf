output "ip_address" {
    value = "${azurerm_container_group.aci_cg.ip_address}"
}