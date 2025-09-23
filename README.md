# Terraform Learning Projects

🏗️ **Personal study repository documenting my Terraform learning journey**

This repository contains my Terraform study materials, infrastructure as code configurations, and learning progression through various Terraform concepts.

## 📁 Repository Structure

### Learning Modules
- **`0.aws_accounts/`** - AWS account setup and configuration
- **`1.getting_started/`** - Basic Terraform concepts and first resources
- **`2.read_generate_modify_configurations/`** - Working with Terraform configurations
- **`3.provisioners/`** - Using provisioners for resource setup
- **`4.modules_workspaces/`** - Terraform modules and workspace management
- **`5.terraform_backend/`** - Backend configuration and state management
- **`6.remote_state/`** - Remote state management patterns
- **`7.import_and_code_generation/`** - Importing existing resources
- **`8.multiple_providers/`** - Working with multiple cloud providers

## 🚀 Common Commands

### Basic Terraform Workflow
```bash
# Initialize Terraform
terraform init

# Plan changes
terraform plan

# Apply changes
terraform apply

# Destroy resources
terraform destroy
```

### State Management
```bash
# Show current state
terraform show

# List resources in state
terraform state list

# Import existing resource
terraform import <resource_type>.<name> <resource_id>
```

### Module Development
```bash
# Validate configuration
terraform validate

# Format code
terraform fmt

# Initialize with modules
terraform get
```

## 🛠️ Development Setup

### Prerequisites
- Terraform CLI
- AWS CLI (configured with appropriate credentials)
- Text editor or IDE with Terraform support

### Getting Started
1. Clone this repository
2. Navigate to any module directory (e.g., `1.getting_started/`)
3. Run `terraform init`
4. Review and modify variables as needed
5. Run `terraform plan` to see planned changes
6. Run `terraform apply` to create resources

## 📚 Learning Path

This repository follows a structured learning approach:

1. **Foundation** (0-1): Basic setup and first resources
2. **Configuration Management** (2-3): Working with configurations and provisioners
3. **Advanced Features** (4-6): Modules, workspaces, and state management
4. **Enterprise Patterns** (7-8): Import workflows and multi-provider setups

---

**🚀 Start your Terraform journey: Navigate to `1.getting_started/` to begin!**