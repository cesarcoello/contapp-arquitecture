variable "project"{
    description = "the name project"
    default = "cont"
}

variable "environment"{
    description = "the enviroment to release"
    default = "dev"
}

variable "location"{
    description = "Azure region"
    default = "East US 2"
}

variable "tags"{
    description = "all tags used"
    default = {
        environment = "dev"
        project = "cont"
        created_by = "terraform"
    }
}

variable "password"{
    description = "sqlserver password"
    type =  string
    sensitive = true
}

