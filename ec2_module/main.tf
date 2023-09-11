resource "aws_instance" "instance" {
  count                       = var.instance_count
  ami                         = var.ami[var.os]
  instance_type               = var.instance_type
  key_name                    = var.keypair
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.sg_id
  source_dest_check           = var.source_dest_check
  associate_public_ip_address = var.associate_public_ip_address

  iam_instance_profile = var.iam_instance_profile
  user_data            = var.user_data

  tags = {
    "Name" = "server"
  }
}