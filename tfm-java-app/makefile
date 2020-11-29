PROJECT_ID=java-apps
REGION=us-east-1
ENV=dev 
BUCKET_NAME=${PROJECT_ID}-${ENV}

# We need this s3 bucket creation here becuase of terraform init which creates states file and stores in that bucket
# Bucket for storing terraform state file
create-tf-bucket:
	aws s3 mb s3://${BUCKET_NAME} --region ${REGION}
# 
echo-variables:
	echo ${BUCKET_NAME} ${REGION}

check-env:
ifndef ENV
	$(error Please set ENV=[dev|staging|prod])
endif

# Create tfm workspace
tfm-cr-wspace: check-env
	cd terraform && \
		terraform workspace new $(ENV)

# list tfm workspace
tfm-list-wspace: check-env
	cd terraform && \
		terraform workspace list

# init tfm workspace
tfm-init: check-env
	cd terraform && \
		terraform workspace select $(ENV) && \
		terraform init
# tfm plan
tfm-plan: check-env
	cd terraform && \
		terraform workspace select $(ENV) && \
		terraform plan \
		-var-file="./environments/common.tfvars" 
# tfm apply
tfm-apply: check-env
	cd terraform && \
		terraform workspace select $(ENV) && \
		terraform apply \
		-var-file="./environments/common.tfvars" 

# tfm destroy
tfm-dest: check-env
	cd terraform && \
		terraform workspace select $(ENV) && \
		terraform destroy \
		-var-file="./environments/common.tfvars"