ifndef CONFIG_DIR
override CONFIG_DIR = config
endif

ifndef COMMON_CONFIG_DIR
override COMMON_CONFIG_DIR = ../environment-config/$(ENVT_NAME)
endif

ifndef TF_STATE_PREFIX
override TF_STATE_PREFIX = $(ENVT_NAME)/palo_alto_instance_group
endif

tf-clean:
	rm -f terraform.tfplan terraform.tfstate .terraform.lock.hcl $(CONFIG_DIR)/terraform.tfplan && rm -fR .terraform/

migrate-state:
	terraform init -migrate-state -backend-config=$(COMMON_CONFIG_DIR)/backend.hcl -backend-config="prefix=$(TF_STATE_PREFIX)"

validate:
	# Validate the infrastructure.
	terraform init -backend-config=$(COMMON_CONFIG_DIR)/backend.hcl -backend-config="prefix=$(TF_STATE_PREFIX)" && terraform get && terraform validate

plan:
	terraform plan -var-file="$(COMMON_CONFIG_DIR)/common.tfvars" -var-file="$(CONFIG_DIR)/config-$(ENVT_NAME).json" -out="$(CONFIG_DIR)/terraform.tfplan"

# Creates/updates the network infrastructure.
apply:
	# Get the modules, create the infrastructure.
	terraform apply -auto-approve -var-file="$(COMMON_CONFIG_DIR)/common.tfvars" -var-file="$(CONFIG_DIR)/config-$(ENVT_NAME).json"

# Destroy the network infrastructure.
destroy:validate
	terraform destroy -var-file="$(COMMON_CONFIG_DIR)/common.tfvars" -var-file="$(CONFIG_DIR)/config-$(ENVT_NAME).json"

#Sleep or turndown the network infrastructure.
hibernate:

#Recreate the network infrastructure.
awake:

# Lint the terraform files. Don't forget to provide the 'region' var, as it is
# not provided by default. Error on issues, suitable for CI.
tf-lint:
	terraform get && TF_VAR_region="ap-southeast-1"  tflint --module --loglevel=info 
	#TF_VAR_region="ap-southeast-1" tflint --error-with-issues