data "aws_route_table" "this_database" {
  for_each  = toset(data.aws_subnets.this_database.ids)
  subnet_id = each.value
}

data "aws_route_table" "this_private" {
  for_each  = toset(data.aws_subnets.this_private.ids)
  subnet_id = each.value
}

data "aws_route_table" "this_public" {
  for_each  = toset(data.aws_subnets.this_public.ids)
  subnet_id = each.value
}

data "aws_ssm_parameter" "availability_zones" {
  name = "/aft/account-request/custom-fields/vpc_availability_zones"
}

data "aws_ssm_parameter" "vpc_cidr" {
  name = "/aft/account-request/custom-fields/vpc_cidr"
}

data "aws_subnets" "this_database" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.this.id]
  }

  tags = {
    tier = "database"
  }
}

data "aws_subnets" "this_private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.this.id]
  }

  tags = {
    tier = "private"
  }
}

data "aws_subnets" "this_public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.this.id]
  }

  tags = {
    tier = "public"
  }
}

data "aws_subnet" "this_database" {
  for_each          = length(data.aws_subnets.this_database.ids) > 0 ? toset(local.availability_zones) : toset([])
  availability_zone = each.value
  vpc_id            = data.aws_vpc.this.id

  tags = {
    tier = "database"
  }
}

data "aws_subnet" "this_private" {
  for_each          = length(data.aws_subnets.this_private.ids) > 0 ? toset(local.availability_zones) : toset([])
  availability_zone = each.value
  vpc_id            = data.aws_vpc.this.id

  tags = {
    tier = "private"
  }
}

data "aws_subnet" "this_public" {
  for_each          = length(data.aws_subnets.this_public.ids) > 0 ? toset(local.availability_zones) : toset([])
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