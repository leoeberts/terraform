resource "aws_instance" "cluster" {
  ami                    = var.ami[var.region]
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.terraform_firewall.id]
  count                  = 3

  tags = {
    Name      = "cluster_#${count.index}"
    Reason    = var.cluster_reason[count.index]
    Condition = count.index < 1 ? "First" : "Not first"
  }

  # Meta arguments
  # depends_on = [aws_security_group.terraform_firewall]
  # - Handle dependencies between resources that Terraform cannot detect automatically
  # provider   = aws.us_east_1
  # - override provider configurations for a resource
  # for_each = aws_eip.lb
  # - Create multiple instances of a resource from a map or set
  # count = 3
  # - Create a specific number of instances of a resource
  # lifecycle
  # - Manage the lifecycle of a resource
  # - ignore_changes = [tags] # ignore changes to tags
  # - create_before_destroy = true # create the new resource before destroying the old one
  # - prevent_destroy = true # prevent the resource from being destroyed
  # - replace_triggered_by = [aws_security_group.terraform_firewall] # replace the resource when the security group is changed

  lifecycle {
    # - create the new resource before destroying the old one, if creation fails the resource is not destroyed
    create_before_destroy = true
    ignore_changes        = [ami, tags]
  }
}

output "cluster_ids" {
  value = aws_instance.cluster[*].id
}

output "cluster_id_by_name" {
  value = zipmap(aws_instance.cluster[*].tags.Name, aws_instance.cluster[*].id)
}
