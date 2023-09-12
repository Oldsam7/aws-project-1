output "instance_id" {
  value = aws_instance.instance[*].id
}

output "instance" {
  value = aws_instance.instance
}