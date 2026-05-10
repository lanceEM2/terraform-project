terraform init -backend-config=dev.conf
terraform init -backend-config=stag.conf

terraform apply -input=false -var-file=dev.tfvars -auto-approve
terraform apply -input=false -var-file=stag.tfvars -auto-approve