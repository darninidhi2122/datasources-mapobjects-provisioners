# VPC object
variable "vpc" {
  type = object({
    name   = string
    cidr   = string
    region = string
  })
}

# Subnets: map of objects
variable "subnets" {
  type = map(object({
    cidr   = string
    az     = string
    public = bool
  }))
}

# EC2 instances: map of objects
variable "instances" {
  type = map(object({
    subnet_key    = string
    instance_type = string
  }))
}

variable "ami_id" {
  type = string
}

variable "key_name" {
  type = string
}
