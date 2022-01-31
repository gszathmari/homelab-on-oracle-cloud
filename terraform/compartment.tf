resource "oci_identity_compartment" "homelab" {
  compartment_id = var.tenancy_ocid
  description    = "Compartment for homelab resources."
  name           = var.compartment_name
  freeform_tags  = var.tags
}
