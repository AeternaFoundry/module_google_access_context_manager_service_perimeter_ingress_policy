variable "access_context_manager_service_perimeter_ingress_policies" {
  description = <<EOT
Map of access_context_manager_service_perimeter_ingress_policies, attributes below
Required:
    - perimeter
Optional:
    - deletion_policy
    - title
    - ingress_from (block):
        - identities (optional)
        - identity_type (optional)
        - sources (optional, block):
            - access_level (optional)
            - psc_endpoint (optional, block):
                - forwarding_rule (optional)
            - resource (optional)
    - ingress_to (block):
        - operations (optional, block):
            - method_selectors (optional, block):
                - method (optional)
                - permission (optional)
            - service_name (optional)
        - resources (optional)
        - roles (optional)
    - timeouts (block):
        - create (optional)
        - delete (optional)
        - update (optional)
EOT

  type = map(object({
    perimeter       = string
    deletion_policy = optional(string)
    title           = optional(string)
    ingress_from = optional(object({
      identities    = optional(list(string))
      identity_type = optional(string)
      sources = optional(list(object({
        access_level = optional(string)
        psc_endpoint = optional(object({
          forwarding_rule = optional(string)
        }))
        resource = optional(string)
      })))
    }))
    ingress_to = optional(object({
      operations = optional(list(object({
        method_selectors = optional(list(object({
          method     = optional(string)
          permission = optional(string)
        })))
        service_name = optional(string)
      })))
      resources = optional(list(string))
      roles     = optional(list(string))
    }))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
  }))
  # Note: 1 additional provider-side validator is enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

