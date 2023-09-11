data "aws_s3_bucket" "s3bucket" {
  bucket = var.BUCKET
}

data "aws_s3_object" "server1_userdata" {
  bucket = var.BUCKET
  key    = var.server1_userdata_key
}

data "aws_s3_object" "server2_userdata" {
  bucket = var.BUCKET
  key    = var.server2_userdata_key
}

#IAM Role to grant EC2 instances access to the S3 bucket
resource "aws_iam_role" "s3_access_role" {
  name = "s3_access_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

#S3 Bucket Policy - defining an IAM policy for S3 access (aws_iam_policy.s3_access_policy) and attaching it to the IAM role (aws_iam_role.s3_access_role).
resource "aws_iam_policy" "s3_access_policy" {
  name        = "s3accesspolicy"
  description = "s3 access policy"

  # Defining the permissions required to access the S3 bucket
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = ["s3:GetObject", "s3:ListBucket", "s3:GetObjectVersion"],
      Effect = "Allow",
      Resource = [
        "${data.aws_s3_bucket.s3bucket.arn}",
        "${data.aws_s3_bucket.s3bucket.arn}/*"
      ],
    }]
  })
}

resource "aws_iam_role_policy_attachment" "s3_access_attachment" {
  policy_arn = aws_iam_policy.s3_access_policy.arn
  role       = aws_iam_role.s3_access_role.name
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "instance_profile"
  role = aws_iam_role.s3_access_role.name
}