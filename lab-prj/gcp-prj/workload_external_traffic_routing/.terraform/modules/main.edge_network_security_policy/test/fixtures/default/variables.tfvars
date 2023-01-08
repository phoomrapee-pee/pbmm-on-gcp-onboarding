security_policy = {
    "gcplb-all-allow-default-deny" = {
      "description" = "Allow all the communication with default deny"
      "versioned_expr" = [
        {
          "action"              = "allow"
          "priority"            = "100"
          "rule_description"    = "Rule to allow all IP Range"
          "src_ip_ranges"       = ["*", ]
          "versioned_expr_name" = "SRC_IPS_V1"
        },
        {
          "action"              = "deny(403)"
          "priority"            = "2147483647"
          "rule_description"    = "Rule to Deny all IP Range"
          "src_ip_ranges"       = ["*", ]
          "versioned_expr_name" = "SRC_IPS_V1"
        }
      ]
      "expr" = []
    },
    "owasp-deny" = {
      "description" = "Deny for all rules matching OWASP expressions"
      "expr" = [
        {
          "action"              = "deny(403)"
          "priority"            = "100"
          "rule_description"    = "Rule to deny all sqli-stable threats"
          "expression"          = "evaluatePreconfiguredExpr('sqli-stable')"
        },
        {
          "action"              = "deny(403)"
          "priority"            = "101"
          "rule_description"    = "Rule to deny all xss-stable threats"
          "expression"          = "evaluatePreconfiguredExpr('xss-stable')"
        }
      ]
      "versioned_expr" = [
        {
          "action"              = "allow"
          "priority"            = "2147483647"
          "rule_description"    = "Rule to allow all IP Range"
          "src_ip_ranges"       = ["*", ]
          "versioned_expr_name" = "SRC_IPS_V1"
        }
      ]
    }
    # ,
    # "gcplb-all-allow" = {
    #   "description" = "Allow all the communication with default deny"
    #   "versioned_expr" = [  
    #     {
    #       "action"              = "allow"
    #       "priority"            = "1000"
    #       "rule_description"    = "Rule to allow all IP Range"
    #       "src_ip_ranges"       = ["10.0.0.1", ]
    #       "versioned_expr_name" = "SRC_IPS_V1"
    #     },
    #     {
    #       "action"              = "deny(403)"
    #       "priority"            = "2147483647"
    #       "rule_description"    = "Rule to Deny all IP Range"
    #       "src_ip_ranges"       = ["*", ]
    #       "versioned_expr_name" = "SRC_IPS_V1"
    #     }
    #   ]
    #   "expr" = []
    # }
}