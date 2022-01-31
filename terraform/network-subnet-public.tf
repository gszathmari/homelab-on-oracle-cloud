resource "oci_core_subnet" "vcn-public-subnet" {
  compartment_id = oci_identity_compartment.homelab.id
  vcn_id         = module.vcn.vcn_id
  cidr_block     = "10.0.0.0/24"
  freeform_tags  = var.tags

  route_table_id = module.vcn.ig_route_id
  security_list_ids = [
    oci_core_security_list.public-security-list.id,
  ]

  display_name    = "public-subnet"
  dhcp_options_id = oci_core_dhcp_options.dhcp-options.id
  dns_label       = "publicsubnet"
}

resource "oci_core_security_list" "public-security-list" {
  compartment_id = oci_identity_compartment.homelab.id
  vcn_id         = module.vcn.vcn_id
  display_name   = "security-list-public"
  freeform_tags  = var.tags

  egress_security_rules {
    stateless        = false
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    protocol         = "all"
  }

  ingress_security_rules {
    stateless   = false
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    protocol    = "6"
    description = "SSH traffic"

    tcp_options {
      min = 22
      max = 22
    }
  }

  ## If you wish to open further network ports to the internet,
  ## add your firewall ACLs as the following:

  #   ingress_security_rules {
  #     stateless   = false
  #     source      = "0.0.0.0/0"
  #     source_type = "CIDR_BLOCK"
  #     protocol    = "6"
  #     description = "HTTP traffic"

  #     tcp_options {
  #       min = 80
  #       max = 80
  #     }

  #   ingress_security_rules {
  #     stateless   = false
  #     source      = "0.0.0.0/0"
  #     source_type = "CIDR_BLOCK"
  #     protocol    = "6"
  #     description = "HTTPS traffic"

  #     tcp_options {
  #       min = 443
  #       max = 443
  #     }

  ingress_security_rules {
    stateless   = false
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    protocol    = "1"
    description = "ICMP Port Unreachable"

    icmp_options {
      type = 3
      code = 4
    }
  }

  ingress_security_rules {
    stateless   = false
    source      = "10.0.0.0/16"
    source_type = "CIDR_BLOCK"
    protocol    = "1"
    description = "ICMP Destination Unreachable"

    icmp_options {
      type = 3
    }
  }

  ingress_security_rules {
    stateless   = false
    source      = "10.0.0.0/16"
    source_type = "CIDR_BLOCK"
    protocol    = "1"
    description = "ICMP Echo Reply"

    icmp_options {
      type = 0
    }
  }

  ingress_security_rules {
    stateless   = false
    source      = "10.0.0.0/16"
    source_type = "CIDR_BLOCK"
    protocol    = "1"
    description = "ICMP Echo"

    icmp_options {
      type = 8
    }
  }
}

resource "oci_core_network_security_group" "homelab-network-security-group" {
  compartment_id = oci_identity_compartment.homelab.id
  vcn_id         = module.vcn.vcn_id
  display_name   = "network-security-group-homelab"
  freeform_tags  = var.tags
}

resource "oci_core_network_security_group_security_rule" "homelab-network-security-group-list-ingress" {
  network_security_group_id = oci_core_network_security_group.homelab-network-security-group.id
  direction                 = "INGRESS"
  source                    = oci_core_network_security_group.homelab-network-security-group.id
  source_type               = "NETWORK_SECURITY_GROUP"
  protocol                  = "all"
  stateless                 = true
}

resource "oci_core_network_security_group_security_rule" "homelab-network-security-group-list-egress" {
  network_security_group_id = oci_core_network_security_group.homelab-network-security-group.id
  direction                 = "EGRESS"
  destination               = oci_core_network_security_group.homelab-network-security-group.id
  destination_type          = "NETWORK_SECURITY_GROUP"
  protocol                  = "all"
  stateless                 = true
}
