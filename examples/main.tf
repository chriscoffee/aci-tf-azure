module "aci" {
    source = "../"

    resource_group =  {
        name = "drone"
    }   

    location = "West Europe"

    storage_account {
        name = "drone_sa"
        account_tier = "Standard"
        account_replication_type = "LRS"
    }

    storage_share {
        name = "drone_ss"
        quota = 50
    }

    container_group {
        name = "drone_cg"
        ip_address_type = "public"
        dns_label_name = "drone_dns"
        os_type = "linux"
    }

    container {
        name = "drone"
        image = "drone/drone:0.8"
        cpu = "0.5"
        memory = "1.5"
        port = "80"

    }

    container {
        name = "drone-agent"
        image = "drone/drone:0.8"
        cpu = "0.5"
        memory = "1.5"

        command = "agent"

        environment_variables {
            DRONE_OPEN = "true"
            DRONE_HOST = ""
            DRONE_GITHUB = "true"
            DRONE_GITHUB_CLIENT = ""
            DRONE_GITHUB_SECRET = ""
            DRONE_SECRET = ""
        }

    }

    # TODO: Finish the following
k