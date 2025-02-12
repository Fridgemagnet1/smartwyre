variable "location" {
  type        = string
  description = "Required. The Azure region for deployment of the this resource."
  nullable    = false
}

variable "name" {
  type        = string
  description = "Required. The name of the this resource."
}

variable "tags" {
  default     = {}
  description = "Common tags"
}