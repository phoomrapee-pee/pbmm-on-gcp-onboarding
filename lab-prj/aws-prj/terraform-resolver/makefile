ifndef COMMON_CONFIG_DIR
override COMMON_CONFIG_DIR = environment-config/$(PROJECT_NAME)/$(ENVT_NAME)
endif

ifndef CONFIG_DIR
override CONFIG_DIR = configs/$(PROJECT_NAME)
endif

tf-clean:
	rm -f terraform.tfplan terraform.tfstate $(CONFIG_DIR)/terraform.tfplan && rm -fR .terraform/

validate:
	# Validate the infrastructure.
	terraform init -backend-config=$(COMMON_CONFIG_DIR)/backend-$(ENVT_NAME).hcl -backend-config="key=platform/terraform_resolver_$(ENVT_NAME)/terraform_resolver_share_$(PROJECT_NAME).tfstate" && terraform get && terraform validate

plan:validate
	terraform init -backend-config=$(COMMON_CONFIG_DIR)/backend-$(ENVT_NAME).hcl -backend-config="key=platform/terraform_resolver_$(ENVT_NAME)/terraform_resolver_share_$(PROJECT_NAME).tfstate" && terraform get -update && terraform plan -var-file="$(CONFIG_DIR)/config-$(ENVT_NAME).json" -out="$(CONFIG_DIR)/terraform.tfplan"

# Creates the network infrastructure.
create:
	# Get the modules, create the infrastructure.
	terraform init -backend-config=$(COMMON_CONFIG_DIR)/backend-$(ENVT_NAME).hcl -backend-config="key=platform/terraform_resolver_$(ENVT_NAME)/terraform_resolver_share_$(PROJECT_NAME).tfstate" && terraform get && terraform apply -auto-approve -var-file="$(CONFIG_DIR)/config-$(ENVT_NAME).json"

# Destroy the network infrastructure.
destroy:
	terraform init -backend-config=$(COMMON_CONFIG_DIR)/backend-$(ENVT_NAME).hcl -backend-config="key=platform/terraform_resolver_$(ENVT_NAME)/terraform_resolver_share_$(PROJECT_NAME).tfstate" && terraform get && terraform destroy -auto-approve -var-file="$(CONFIG_DIR)/config-$(ENVT_NAME).json"

# Lint the terraform files. Don't forget to provide the 'region' var, as it is
# not provided by default. Error on issues, suitable for CI.
tf-lint:
	terraform get
	TF_VAR_region="ap-southeast-1" tflint --error-with-issues
