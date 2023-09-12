output "server1_id" {
  value = module.server1.instance_id
}
output "server2_id" {
  value = module.server2.instance_id
}

output "user_data2" {
  value = module.s3.server2_userdata
}



