module "environment" {
  source   = "./environment"
  environment = var.environment
}

module "resource_type" {
  source   = "./resource_type"
  resource_type = var.resource_type
}

module "suffix" {
  source   = "./suffix"
}
module "location" {
  count    = var.location == null ? 0 : 1
  source   = "./location"
  location = var.location
}

module "validate" {
  source             = "./main"
  environment_abbr   = module.environment.abbr
  resource_type_abbr = module.resource_type.abbr
  suffix             = module.suffix.generated
  location_abbr      = var.location == null ? "" : tostring(module.location[0].abbr)
  # prefix             = var.prefix
  # tenant_name        = var.tenant_name
  # job                = var.job
}
