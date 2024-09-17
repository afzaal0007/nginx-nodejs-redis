# Step 1: Create IAM Role for Fluent Bit  
resource "aws_iam_role" "fluent_bit_role" {
  name               = "fluent-bit-role"
  assume_role_policy = data.aws_iam_policy_document.fluent_bit_assume_policy.json
}

data "aws_iam_policy_document" "fluent_bit_assume_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["fluentbit.amazonaws.com"]
    }
  }
}


# Step 3: Create Log Group for Fluent Bit  
resource "aws_cloudwatch_log_group" "fluent_bit_log_group" {
  name = "/fluent-bit/log"
}


resource "kubernetes_config_map" "fluent_bit_config" {
  metadata {
    name      = "fluent-bit-config"
    namespace = "monitoring"
  }

  data = {
    "fluent-bit.conf" = file("fluent-bit.conf")
  }
}
