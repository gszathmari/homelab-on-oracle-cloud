module "vcn" {
  source  = "oracle-terraform-modules/vcn/oci"
  version = "2.2.0"

  compartment_id = oci_identity_compartment.homelab.id
  region         = "ap-southeast-2"
  vcn_name       = var.compartment_name
  vcn_dns_label  = var.compartment_name

  internet_gateway_enabled = true
  nat_gateway_enabled      = false
  service_gateway_enabled  = false
  vcn_cidr                 = "10.0.0.0/16"
}
