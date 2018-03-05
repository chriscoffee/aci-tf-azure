variable "resource_group" {
    description = "The name of the resource group in which to create the Container Group. Changing this forces a new resource to be created."
    type = "map"
}

variable "location" {
    description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created"
    default = "West Europe" // Not availiable in UK South as of yet.
}

variable "environment_variables" {
    description = "Input the map of environment variables in the standard map format"
    type = "map"
}
