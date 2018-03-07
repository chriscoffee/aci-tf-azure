variable "resource_group" {
    description = "The name of the resource group in which to create the Container Group. Changing this forces a new resource to be created."
    type = "map"
}

variable "location" {
    description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created"
    default = "West Europe" // Not availiable in UK South as of yet.
}

variable "storage_account" {
    description = "Input the map for the storage account, required fields are name, account tier and account replication type"
    type = "map"
    /*
       default = {
          name = ""
          account_tier = ""
      }
     */
}

variable "storage_share" {
    description = "Input the map for the storage share, required fields are name and quota."
    type = "map"
    /*
       default = {
          name = ""
          quota = ""
      }
     */
}

variable "container_group" {
    description = "Input the map for container group, required fields are name, ip address type, dns label name and os type."
    type = "map"
    /*
       default = {
          name = ""
          ip_address_type = ""
          dns_label_name = ""
          os_type = ""
      }
     */
}

// This will be filled in with pre-step which is why it's a map
variable "container" {
    description = "Input the map for the container, required files are name, image, cpu, memory, port"
    type = "map"
    /*
       default = {
          name = ""
          image = ""
          cpu = ""
          memory = ""
          port = ""
      }
     */
}

variable "environment_variables" {
    description = "Input the map of environment variables, require fields are name."
    type = "map"
}

variable "command" {
    description = "A command line to be run on the container. Changing this forces a new resource to be created."
}

variable "environment" {
    description = "The default environment"
}