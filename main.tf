
data "aws_ssm_parameter" "availability_zones" {
  name = "/aft/account-request/custom-fields/vpc_availability_zones"
}

data "aws_ssm_parameter" "vpc_cidr" {
  name = "/aft/account-request/custom-fields/vpc_cidr"
}

data "aws_subnet" "this_database" {
  for_each          = toset(local.availability_zones)
  availability_zone = each.value
  vpc_id            = data.aws_vpc.this.id

  tags = {
    tier = "database"
  }
}

data "aws_subnet" "this_private" {
  for_each          = toset(local.availability_zones)
  availability_zone = each.value
  vpc_id            = data.aws_vpc.this.id

  tags = {
    tier = "private"
  }
}

data "aws_subnet" "this_public" {
  for_each          = toset(local.availability_zones)
  availability_zone = each.value
  vpc_id            = data.aws_vpc.this.id

  tags = {
    tier = "public"
  }
}

data "aws_vpc" "this" {
  cidr_block = data.aws_ssm_parameter.vpc_cidr.insecure_value
}

locals {
  availability_zones = split(",", replace(data.aws_ssm_parameter.availability_zones.insecure_value,"/[\\[\\]\" ]*/",""))
}