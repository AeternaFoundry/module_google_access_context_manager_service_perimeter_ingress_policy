resource "google_access_context_manager_service_perimeter_ingress_policy" "access_context_manager_service_perimeter_ingress_policies" {
  for_each = var.access_context_manager_service_perimeter_ingress_policies

  perimeter       = each.value.perimeter
  deletion_policy = each.value.deletion_policy
  title           = each.value.title

  dynamic "ingress_from" {
    for_each = each.value.ingress_from != null ? [each.value.ingress_from] : []
    content {
      identities    = ingress_from.value.identities
      identity_type = ingress_from.value.identity_type
      dynamic "sources" {
        for_each = ingress_from.value.sources != null ? ingress_from.value.sources : []
        content {
          access_level = sources.value.access_level
          dynamic "psc_endpoint" {
            for_each = sources.value.psc_endpoint != null ? [sources.value.psc_endpoint] : []
            content {
              forwarding_rule = psc_endpoint.value.forwarding_rule
            }
          }
          resource = sources.value.resource
        }
      }
    }
  }

  dynamic "ingress_to" {
    for_each = each.value.ingress_to != null ? [each.value.ingress_to] : []
    content {
      dynamic "operations" {
        for_each = ingress_to.value.operations != null ? ingress_to.value.operations : []
        content {
          dynamic "method_selectors" {
            for_each = operations.value.method_selectors != null ? operations.value.method_selectors : []
            content {
              method     = method_selectors.value.method
              permission = method_selectors.value.permission
            }
          }
          service_name = operations.value.service_name
        }
      }
      resources = ingress_to.value.resources
      roles     = ingress_to.value.roles
    }
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }
}

