variable "compartment_name" {
  description = "The name of the compartment."
  type        = string
}

variable "tenancy_ocid" {
  description = "The OCID of the tenancy."
  type        = string
}

variable "user_ocid" {
  description = "The OCID of the user."
  type        = string
}

variable "vm_image_ocid_x86_64" {
  description = "The OCID of the VM image to be deployed (x86_64)."
  type        = string
}

variable "vm_image_ocid_ampere" {
  description = "The OCID of the VM image to be deployed (ampere)."
  type        = string
}

variable "vm_name" {
  description = "Name of the homelab virtual machine."
  type        = string
}

variable "region" {
  description = "The name of the cloud region."
  type        = string
  default     = "ap-sydney-1"
}

variable "fingerprint" {
  description = "The fingerprint of the private key."
  type        = string
}

variable "private_key_path" {
  description = "The location of the private key."
  type        = string
}

variable "ssh_public_key" {
  description = "The value of your SSH public key."
  type        = string
}

variable "tags" {
  description = "Freeform tags."
  type        = map(any)
}
