provider "azurerm" {
    features{}
    # subscription_id = "4d14920f-f57e-4470-8ba0-04827bfd7f03"
}

# variable "location" {
#     type = string
# }
variable "tags"{
    type = list(object({
        role = string
        env = string
    }))
}

resource "azurerm_resource_group" "rg"{
    name = "test-rg"
    location = "eastus2"
}


resource "azurerm_virtual_network" "vnet" {
    name = "dev_vnet"
    resource_group_name = "test-rg"
    address_space = ["10.0.0.0/16"]
    location = azurerm_resource_group.rg.location
    tags = {
        role = var.tags[0].role
        env = var.tags[1].env
        OS = "Linux"
    }
}

output "vnet_id"{
    value = azurerm_virtual_network.vnet.id
}