locals {
  server1_id       = module.server1.instance_id
  server2_id       = module.server2.instance_id
  subnet1_id       = module.vpc.publicsubnet1_id
  subnet2_id       = module.vpc.publicsubnet2_id
  instance_profile = module.s3.instance_profile
  instance1        = module.server1.instance
  instance2        = module.server2.instance
}

module "vpc" {
  source = ".//vpc_module"
}

module "s3" {
  source               = ".//s3_module"
  BUCKET               = var.BUCKET
  server1_userdata_key = var.server1_userdata_key
  server2_userdata_key = var.server2_userdata_key
}

module "alb" {
  source               = ".//alb_module"
  tg_port              = var.tg_port
  target_type          = var.target_type
  tg_protocol          = var.tg_protocol
  vpc_id               = module.vpc.vpc_id
  protocol_version     = var.protocol_version
  instance_id1         = local.server1_id[0]
  instance_id2         = local.server2_id[0]
  instance_ids         = [local.server1_id, local.server2_id]
  load_balancer_type   = var.load_balancer_type
  subnet1_id           = local.subnet1_id
  subnet2_id           = local.subnet2_id
  server1_userdata_key = var.server1_userdata_key
  server2_userdata_key = var.server2_userdata_key
  protocol             = var.protocol
}

module "server1" {
  source                      = ".//ec2_module"
  instance_count              = 1
  os                          = var.os
  instance_type               = var.instance_type
  keypair                     = var.keypair
  subnet_id                   = local.subnet1_id
  sg_id                       = [module.securitygroup.sg_id]
  source_dest_check           = false
  associate_public_ip_address = true

  #associating IAM role (aws_iam_role.s3_access_role) with EC2 instance (Server1) using the iam_instance_profile attribute.
  iam_instance_profile = local.instance_profile

  user_data = module.s3.server1_userdata

}

module "server2" {
  source                      = ".//ec2_module"
  instance_count              = 1
  os                          = var.os
  instance_type               = var.instance_type
  keypair                     = var.keypair
  subnet_id                   = local.subnet2_id
  sg_id                       = [module.securitygroup.sg_id]
  source_dest_check           = false
  associate_public_ip_address = true

  #associating IAM role (aws_iam_role.s3_access_role) with EC2 instance (Server1) using the iam_instance_profile attribute.
  iam_instance_profile = local.instance_profile

  user_data = module.s3.server2_userdata
}

module "securitygroup" {
  source = ".//securitygroup_module"
  vpc_id = module.vpc.vpc_id
  myip   = var.myip
}