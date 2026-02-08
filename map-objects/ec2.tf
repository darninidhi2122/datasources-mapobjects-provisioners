resource "aws_instance" "this" {
  for_each = var.instances

  ami           = var.ami_id
  instance_type = each.value.instance_type
  subnet_id     = aws_subnet.this[each.value.subnet_key].id
  key_name      = var.key_name

  tags = {
    Name = each.key
  }
}
