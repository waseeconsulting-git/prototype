# IAM Role for EC2 with SSM Session Manager support
resource "aws_iam_role" "ec2_secrets_role" {
  name = "${var.env_prefix}-ec2-ssm-role"  # Updated name for clarity

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })

  tags = var.tags
}

# ⭐ CRITICAL: SSM MANAGED POLICY FOR SESSION MANAGER (REQUIRED)
resource "aws_iam_role_policy_attachment" "ssm_managed_core" {
  role       = aws_iam_role.ec2_secrets_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# ⭐ REMOVE THIS BROAD POLICY - BREAKS LEAST PRIVILEGE!
# resource "aws_iam_role_policy" "ec2_policy" {
#   name = "ec2_policy"
#   role = aws_iam_role.ec2_secrets_role.id
#   policy = jsonencode({
#     Statement = [{
#       Action = ["ec2:Describe*", "logs:PutMetricFilter", ...]  # TOO BROAD!
#       Resource = "*"
#     }]
#   })
# }

# INSTEAD: Minimal EC2 describe policy (if your app needs it)
resource "aws_iam_policy" "ec2_minimal" {
  count = var.enable_ec2_describe ? 1 : 0

  name        = "${var.env_prefix}-ec2-minimal-policy"
  description = "Minimal EC2 permissions for self-description"
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "ec2:DescribeInstances"
        Resource = "*"  # Required for DescribeInstances
        Condition = {
          StringEquals = {
            "ec2:ResourceTag/Name" = "${var.env_prefix}-app-instance"
          }
        }
      }
    ]
  })
}

# ⭐ FIXED: Secrets Manager Policy (Specific Secret Only)
resource "aws_iam_policy" "ec2_secrets_policy" {
  name        = "${var.env_prefix}-EC2ReadRDSSecret"
  description = "Allow EC2 to read ONLY the lab/rds/mysql secret"
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "ReadSpecificSecret"
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]
        # ⭐ FIXED: Specific ARN only, NO WILDCARD
        Resource = var.secret_arn  # Must pass from root module
      },
      {
        Sid    = "AllowKMSDecrypt"
        Effect = "Allow"
        Action = "kms:Decrypt"
        Resource = var.kms_key_arn  # Optional, remove if not using KMS
      }
    ]
  })

  tags = var.tags
}

# ⭐ FIXED: SSM Parameter Store Policy (Specific Parameters Only)
resource "aws_iam_policy" "ssm_read" {
  name        = "${var.env_prefix}-ssm-read-policy"
  description = "Read access to specific SSM parameters"
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ssm:GetParameter",
          "ssm:GetParameters"
          # ⭐ REMOVED: "ssm:GetParametersByPath" (not needed)
        ]
        # ⭐ FIXED: Only 3 specific parameters, not wildcards
        Resource = [
          "arn:aws:ssm:${var.region}:${var.account_id}:parameter/lab/db/endpoint",
          "arn:aws:ssm:${var.region}:${var.account_id}:parameter/lab/db/port",
          "arn:aws:ssm:${var.region}:${var.account_id}:parameter/lab/db/name"
        ]
      }
    ]
  })

  tags = var.tags
}

# ⭐ FIXED: CloudWatch Logs Policy (Specific Log Group Only)
resource "aws_iam_policy" "cloudwatch_logs" {
  name        = "${var.env_prefix}-cloudwatch-logs-policy"
  description = "Write access to specific CloudWatch log group"
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams"
        ]
        # ⭐ FIXED: Specific log group only (no wildcards)
        Resource = "arn:aws:logs:${var.region}:${var.account_id}:log-group:${var.log_group_name}:*"
      }
    ]
  })

  tags = var.tags
}

# ⭐ NEW: CloudWatch Metrics Policy (for app metrics)
resource "aws_iam_policy" "cloudwatch_metrics" {
  name        = "${var.env_prefix}-cloudwatch-metrics-policy"
  description = "Write access to CloudWatch metrics"
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "cloudwatch:PutMetricData"
        Resource = "*"  # Required for custom metrics
        Condition = {
          StringEquals = {
            "cloudwatch:namespace" = [
              "Lab/RDSApp",  # Your app's namespace
              "AWS/EC2"      # Optional: for EC2 metrics
            ]
          }
        }
      }
    ]
  })

  tags = var.tags
}

# ⭐ REMOVE THIS - TOO PERMISSIVE!
# resource "aws_iam_role_policy_attachment" "cw_agent" {
#   role       = aws_iam_role.ec2_secrets_role.name
#   policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"  # TOO BROAD!
# }

# ⭐ ATTACH ALL POLICIES
resource "aws_iam_role_policy_attachment" "secrets_attach" {
  role       = aws_iam_role.ec2_secrets_role.name
  policy_arn = aws_iam_policy.ec2_secrets_policy.arn
}

resource "aws_iam_role_policy_attachment" "ssm_read" {
  role       = aws_iam_role.ec2_secrets_role.name
  policy_arn = aws_iam_policy.ssm_read.arn
}

resource "aws_iam_role_policy_attachment" "cloudwatch_logs" {
  role       = aws_iam_role.ec2_secrets_role.name
  policy_arn = aws_iam_policy.cloudwatch_logs.arn
}

resource "aws_iam_role_policy_attachment" "cloudwatch_metrics" {
  role       = aws_iam_role.ec2_secrets_role.name
  policy_arn = aws_iam_policy.cloudwatch_metrics.arn
}

resource "aws_iam_role_policy_attachment" "ec2_minimal" {
  count = var.enable_ec2_describe ? 1 : 0
  
  role       = aws_iam_role.ec2_secrets_role.name
  policy_arn = aws_iam_policy.ec2_minimal[0].arn
}

# Instance Profile for EC2
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.env_prefix}-ec2-ssm-profile"
  role = aws_iam_role.ec2_secrets_role.name

  tags = var.tags
}