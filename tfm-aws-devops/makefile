PROJECT_ID=devops-directive-storybooks
ZONE=us-central1-a

run-local:
	docker-compose up 

### Creting GCP Bucket

create-tf-backend-bucket:
	gsutil mb -p $(PROJECT_ID) gs://$(PROJECT_ID)-terraform

### Terraform create workspace 
ENV=staging

terraform-create-workspace: 
  cd terraform && \
     terraform workspace new ${ENV}
# How to run make command
# make terraform-create-workspace

### Terraform init
terraform-init:
  cd terraform && \
    terraform workspace select ${ENV} && \
	terraform init
# make terraform-init

