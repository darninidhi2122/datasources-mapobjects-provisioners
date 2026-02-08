resource "aws_instance" "this" {
  for_each = aws_subnet.this

  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = each.value.id
  key_name      = var.key_name

  tags = {
    Name = "ec2-${each.key}"
  }
}
