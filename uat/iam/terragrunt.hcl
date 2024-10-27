include {
    path = find_in_parent_folders()
}

terraform {
    source = "../../terraform-modules//aws-iam"
}

locals {
    common_vars = yamldecode(
        file("${find_in_parent_folders("common_vars.yaml")}"),
    )
}

inputs = {
    env_name = local.common_vars.env
    shared_tags = local.common_vars.shared_tags
    bucket_name = "vw-demo-${local.common_vars.env}-730335502100-data"
    aws_region = "eu-west-1"
}