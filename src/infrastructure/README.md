cd src/infrastructure
terraform init -backend-config="env_dev/backend_config.hcl"
terraform plan -var-file=env_dev/variables.tfvars

<!-- terraform apply -var-file=env_dev/variables.tfvars -->
terraform apply -var-file=env_dev/variables.tfvars -auto-approve