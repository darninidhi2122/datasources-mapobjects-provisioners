resource "aws_subnet" "this" {
  for_each = toset(data.aws_availability_zones.available.names)

  vpc_id            = aws_vpc.this.id
  availability_zone = each.key
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, index(data.aws_availability_zones.available.names, each.key))

  tags = {
    Name = "subnet-${each.key}"
  }
}

# Automatically calculates CIDRs
# One subnet per AZ
# No overlap