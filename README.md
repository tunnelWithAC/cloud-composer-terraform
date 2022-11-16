## Google Cloud Composer Terraform

PoC work for setting up Google Cloud Composer using Airflow 2 as part of a migration away from Airflow 1.

```
cd src/infrastructure

terraform init -backend-config="env_dev/backend_config.hcl"

terraform plan -var-file=env_dev/variables.tfvars

<!-- terraform apply -var-file=env_dev/variables.tfvars -->
terraform apply -var-file=env_dev/variables.tfvars -auto-approve
```

