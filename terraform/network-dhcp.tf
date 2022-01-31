# Source from https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_dhcp_options

resource "oci_core_dhcp_options" "dhcp-options" {
  compartment_id = oci_identity_compartment.homelab.id
  vcn_id         = module.vcn.vcn_id
  display_name   = "homelab-dhcp-options"
  freeform_tags  = var.tags

  options {
    type        = "DomainNameServer"
    server_type = "VcnLocalPlusInternet"
  }

  options {
    type                = "SearchDomain"
    search_domain_names = ["homelab.oraclevcn.com"]
  }

}
