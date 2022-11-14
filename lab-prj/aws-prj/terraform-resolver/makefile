ifndef CONFIG_DIR
override CONFIG_DIR = configs
endif


tf-clean:
	rm -f terraform.tfplan terraform.tfstate && rm -fR .terraform/

validate:
	# Validate the infrastructure.
	terraform init -backend-config=$(CONFIG_DIR)/backend-$(ENV_NAME).hcl && terraform get && terraform validate

plan:validate
	terraform init -backend-config=$(CONFIG_DIR)/backend-$(ENV_NAME).hcl && terraform get -update && terraform plan -var-file="$(CONFIG_DIR)/$(PROJECT_NAME)/config-$(ENV_NAME).json" -out="$(CONFIG_DIR)/terraform.tfplan"

# Creates the network infrastructure.
create:
	# Get the modules, create the infrastructure.
	terraform init -backend-config=$(CONFIG_DIR)/backend-$(ENV_NAME).hcl && terraform get && terraform apply -auto-approve -var-file="$(CONFIG_DIR)/$(PROJECT_NAME)/config-$(ENV_NAME).json"

# Destroy the network infrastructure.
destroy:
	terraform init -backend-config=$(CONFIG_DIR)/backend-$(ENV_NAME).hcl && terraform get && terraform destroy -auto-approve -var-file="$(CONFIG_DIR)/$(PROJECT_NAME)/config-$(ENV_NAME).json"

# Lint the terraform files. Don't forget to provide the 'region' var, as it is
# not provided by default. Error on issues, suitable for CI.
tf-lint:
	terraform get
	TF_VAR_region="ap-southeast-1" tflint --error-with-issues
