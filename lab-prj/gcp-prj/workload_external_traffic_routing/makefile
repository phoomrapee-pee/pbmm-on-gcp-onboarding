ifndef CONFIG_DIR
override CONFIG_DIR = config/$(PROJECT_NAME)
endif

ifndef COMMON_CONFIG_DIR
override COMMON_CONFIG_DIR = ../environment-config/$(PROJECT_NAME)/$(ENVT_NAME)
endif

ifndef TF_STATE_PREFIX
override TF_STATE_PREFIX = $(ENVT_NAME)/external_traffic_routing
endif


tf-clean:	guard-ENVT_NAME guard-PROJECT_NAME
	rm -f terraform.tfplan terraform.tfstate .terraform.lock.hcl $(CONFIG_DIR)/terraform.tfplan && rm -fR .terraform/

migrate-state:	guard-ENVT_NAME guard-PROJECT_NAME
	terraform init -migrate-state -backend-config=$(COMMON_CONFIG_DIR)/backend.hcl -backend-config="prefix=$(TF_STATE_PREFIX)"

validate:	guard-ENVT_NAME guard-PROJECT_NAME
	# Validate the infrastructure.
	terraform init -backend-config=$(COMMON_CONFIG_DIR)/backend.hcl -backend-config="prefix=$(TF_STATE_PREFIX)" && terraform get && terraform validate

plan:	guard-ENVT_NAME guard-PROJECT_NAME
	terraform plan -var-file="$(COMMON_CONFIG_DIR)/common.tfvars" -var-file="$(CONFIG_DIR)/config-$(ENVT_NAME).json" -out="$(CONFIG_DIR)/terraform.tfplan"

# Creates/updates the network infrastructure.
apply:	guard-ENVT_NAME guard-PROJECT_NAME
	# Get the modules, create the infrastructure.
	terraform apply -auto-approve -var-file="$(COMMON_CONFIG_DIR)/common.tfvars" -var-file="$(CONFIG_DIR)/config-$(ENVT_NAME).json"

# Destroy the network infrastructure.
destroy:	guard-ENVT_NAME guard-PROJECT_NAME
	terraform destroy -var-file="$(COMMON_CONFIG_DIR)/common.tfvars" -var-file="$(CONFIG_DIR)/config-$(ENVT_NAME).json"

#Sleep or turndown the network infrastructure.
hibernate:	guard-ENVT_NAME guard-PROJECT_NAME

#Recreate the network infrastructure.
awake:	guard-ENVT_NAME guard-PROJECT_NAME

# Lint the terraform files. Don't forget to provide the 'region' var, as it is
# not provided by default. Error on issues, suitable for CI.
tf-lint:
	terraform get && TF_VAR_region="ap-southeast-1"  tflint --module --loglevel=info 
	#TF_VAR_region="ap-southeast-1" tflint --error-with-issues


guard-%:
	@ if [ "${${*}}" = "" ]; then \
		echo "Environment variable $* not set"; \
		exit 1; \
	fi