#     [ variables.tf ]
#             |
#           /   \
#         /      \
#       /         \
# [dev.tfvars]   [prod.tfvars]
#
# We can use .tfvars files to provide different values for variables defined in variables.tf, 
# allowing you to manage separate configurations for different environments (e.g., dev, prod).
#
# Example:
#   terraform apply --var-file="dev.tfvars"
#   terraform apply --var-file="prod.tfvars"
#
# This way, you can easily switch between environments by selecting the appropriate tfvars file.


# Call with: terraform apply -var-file="tokyo.tfvars"
region    = "ap-northeast-1"
ami       = "ami-0bb2c57f7cfafb1cb"
ipv4_cidr = "10.0.0.0/16"
