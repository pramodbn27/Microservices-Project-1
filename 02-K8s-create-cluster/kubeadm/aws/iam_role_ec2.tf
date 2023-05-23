data "aws_iam_policy" "ssmpolicy" {
  name = "AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role" "ec2_ssm_roles" {
  name = "ec2_ssm_roles"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    created = "terraform"
  }
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_ssm_profile"
  role = aws_iam_role.ec2_ssm_roles.name
}

resource "aws_iam_policy_attachment" "policy-attach" {
  name       = "policy-attachment"
  roles      = [aws_iam_role.ec2_ssm_roles.name]
  policy_arn = data.aws_iam_policy.ssmpolicy.arn
}