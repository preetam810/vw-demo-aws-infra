include {
    path = find_in_parent_folders()
}

terraform {
    source = "../../terraform-modules//aws-lambda"
}

locals {
    common_vars = yamldecode(
        file("${find_in_parent_folders("common_vars.yaml")}"),
    )
}

inputs = {
    env_name = local.common_vars.env
    shared_tags = local.common_vars.shared_tags
    aws_region = "eu-west-1"
    lambda_function_name  = "lambda-s3-dynamodb-${local.common_vars.env}"
    build_repository_type = "snapshots"
    build_version_to_deploy = "python-app-snapshot-29102024.zip"
    data_bucket_name = "vw-demo-${local.common_vars.env}-730335502100-data"
}