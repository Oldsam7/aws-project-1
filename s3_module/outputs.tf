output "role" {
  value       = aws_iam_role.s3_access_role
  description = "IAM Role to grant EC2 instances access to the S3 bucket"
}

output "policy" {
  value       = aws_iam_policy.s3_access_policy
  description = "S3 Bucket Policy defining an IAM policy for S3 access (aws_iam_policy.s3_access_policy) and attaching it to the IAM role (aws_iam_role.s3_access_role)."
}

output "role_name" {
  value       = aws_iam_role.s3_access_role.name
  description = "IAM Role name"
}
output "server1_userdata" {
  value = data.aws_s3_object.server1_userdata.body
}
output "server2_userdata" {
  value = data.aws_s3_object.server2_userdata.body
}
