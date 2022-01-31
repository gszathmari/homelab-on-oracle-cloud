resource "oci_core_volume_backup_policy" "homelab_volume_backup_policy" {
  compartment_id = oci_identity_compartment.homelab.id
  display_name   = "homelab"
  freeform_tags  = var.tags

  schedules {
    backup_type       = "INCREMENTAL"
    day_of_month      = 1
    day_of_week       = "FRIDAY"
    hour_of_day       = 3
    month             = "JANUARY"
    offset_seconds    = 0
    offset_type       = "STRUCTURED"
    period            = "ONE_WEEK"
    retention_seconds = 3024000 # 5 weeks
    time_zone         = "REGIONAL_DATA_CENTER_TIME"
  }
}

resource "oci_core_volume_backup_policy_assignment" "homelab_boot_volume_backup_policy_assignment" {
  count     = 3
  asset_id  = data.oci_core_boot_volumes.homelab_boot_volumes.boot_volumes[count.index].id
  policy_id = oci_core_volume_backup_policy.homelab_volume_backup_policy.id

  depends_on = [
    oci_core_instance.vm_instance_x86_64,
    oci_core_instance.vm_instance_ampere
  ]
}
