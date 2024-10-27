include {
    path = find_in_parent_folders()
}

terraform {
    source = "../../terraform-modules//aws-dynamodb"
}

locals {
    common_vars = yamldecode(
        file("${find_in_parent_folders("common_vars.yaml")}"),
    )
}

inputs = {
    env_name = local.common_vars.env
    shared_tags = local.common_vars.shared_tags
}