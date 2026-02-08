vpc = {
  name   = "demo-vpc"
  cidr   = "10.0.0.0/16"
  region = "ap-south-2"
}

subnets = {
  public_subnet = {
    cidr   = "10.0.1.0/24"
    az     = "ap-south-2a"
    public = true
  }

  private_subnet = {
    cidr   = "10.0.101.0/24"
    az     = "ap-south-2a"
    public = false
  }
}

instances = {
  public_ec2 = {
    subnet_key    = "public_subnet"
    instance_type = "t3.micro"
  }

  private_ec2 = {
    subnet_key    = "private_subnet"
    instance_type = "t3.micro"
  }
}

ami_id   = "ami-02774d409be696d81"
key_name = "nidhi-outlook"
