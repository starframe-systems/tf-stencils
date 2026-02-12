
variable "inherited_tags" {
  type        = map(string)
  description = "Map of tags inherited from parent context"
  default     = {}
}

variable "name" {
  type        = string
  description = "name of this invocation of this module; ex: 'apigw' (generic use), or 'handler' (handler-specific-use)"
}
variable "description" {
  type        = string
  description = "arbitrary description of this api gateway and its purpose"
  default     = "default description change me"
}
variable "prefix" {
  type        = string
  description = "string to prepend to all resource names; Ex: 'org-dev-usersvc-'; this would result in resource names like 'org-dev-usersvc-handler-apigw'"
}
variable "openapi_paths" {
  type        = map(any)
  description = "List of OpenAPI integration objects that define routes for the REST API. Mutually exclusive with `openapi_specification` and `handler_function_name`."
  default     = {}
}
variable "openapi_specification" {
  type        = string
  description = "OpenAPI specification that defines the set of routes and integrations to create as part of the REST API. Mutually exclusive with `openapi_paths` and `handler_function_name`."
  default     = null
}
variable "handler_function_name" {
  type        = string
  description = "The name of the handler Lambda function. Required for the default OpenAPI specification to work and mutually exclusive with `openapi_paths` and `openapi_specification`."
  default     = null
}
variable "api_gateway_stage_name" {
  type        = string
  description = "name of the api gateway stage; appears in the invoke url: https://.../<stage_name>"
  default     = "default_stage_name_change_me"
}

######

##  CUSTOM DOMAIN / CNAME
variable "enable_custom_cname_creation" {
  type        = bool
  description = "enable creating a new custom CNAME, if this is enabled, then a new API Gateway resource will be created'"
  default     = false
}

variable "enable_custom_cname" {
  type        = bool
  description = "enable custom CNAME record pointing to gateway stage endpoint; I.e.: 'https://api.env.example.com/live' insead of 'https://qb2ziqdoxc.execute-api.us-west-2.amazonaws.com/live'"
  default     = false
}
variable "custom_cname_hostname" {
  type        = string
  description = "hostname portion of endpoint CNAME record, without the domain name; I.e.: the 'api' in 'api.env.example.com'"
  default     = ""
}
variable "custom_cname_domain" {
  type        = string
  description = "domain portion of the endpoint CNAME, without the hostname; I.e.: the 'env.example.com' in 'api.env.example.com'; domain must be a Route53 hosted zone in the same AWS account for automatic cert validation and CNAME record creation"
  default     = ""
}
variable "custom_cname_base_path_map" {
  description = "path portion of the endpoint CNAME, without the hostname; I.e.: the 'path' in 'api.env.example.com/path'"
  default     = null
}
variable "custom_cname_route53_zone_id" {
  type        = string
  description = "Route53 hosted zone ID for custom_cname_domain"
  default     = null
}
