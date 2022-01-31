resource "oci_core_volume" "vm_instance_homelab_core_volume" {
  compartment_id       = oci_identity_compartment.homelab.id
  availability_domain  = data.oci_identity_availability_domains.ads.availability_domains[0].name
  display_name         = join("-", [var.vm_name, "core", "volume"])
  freeform_tags        = var.tags
  size_in_gbs          = 59
  is_auto_tune_enabled = true
}

resource "oci_core_volume_backup_policy_assignment" "homelab_core_volume_backup_policy_assignment" {
  asset_id  = oci_core_volume.vm_instance_homelab_core_volume.id
  policy_id = oci_core_volume_backup_policy.homelab_volume_backup_policy.id

  depends_on = [
    oci_core_instance.vm_instance_x86_64,
    oci_core_instance.vm_instance_ampere
  ]
}

resource "oci_core_volume_attachment" "test_volume_attachment" {
  attachment_type                     = "paravirtualized"
  instance_id                         = oci_core_instance.vm_instance_ampere.id
  volume_id                           = oci_core_volume.vm_instance_homelab_core_volume.id
  device                              = "/dev/oracleoci/oraclevdb"
  display_name                        = "homelab-core-volume-attachment"
  is_pv_encryption_in_transit_enabled = true
  is_read_only                        = false
}
