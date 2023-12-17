output "availability_zones" {
  description = "A list of availability zones for the VPC"
  value       = local.availability_zones
}

output "database_subnets" {
  description = "List of IDs of database subnets"
  value = data.aws_subnets.this_database.ids
}

output "database_subnets_az_map" {
  description = "Map of database subnets by AZ"
  value = data.aws_subnet.this_database
}

output "database_subnets_cidr_blocks" {
  description = "List of cidr_blocks of database subnets"
  value = [for k, v in data.aws_subnet.this_database : v.cidr_block]
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value = data.aws_subnets.this_private.ids
}

output "private_subnets_az_map" {
  description = "Map of private subnets by AZ"
  value = data.aws_subnet.this_private
}

output "private_subnets_cidr_blocks" {
  description = "List of cidr_blocks of private subnets"
  value       = [for k, v in data.aws_subnet.this_private : v.cidr_block]
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value = data.aws_subnets.this_public.ids
}

output "public_subnets_az_map" {
  description = "Map of public subnets by AZ"
  value = data.aws_subnet.this_public
}

output "public_subnets_cidr_blocks" {
  description = "List of cidr_blocks of public subnets"
  value       = [for k, v in data.aws_subnet.this_public : v.cidr_block]
}

output "vpc_arn" {
  description = "The ARN of the VPC"
  value       = data.aws_vpc.this.arn
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = data.aws_vpc.this.cidr_block
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = data.aws_vpc.this.id
}
