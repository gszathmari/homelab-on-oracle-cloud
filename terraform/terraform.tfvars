# Refer to the README.md file to fill these in
tenancy_ocid     = ""
user_ocid        = ""
private_key_path = ""
fingerprint      = ""
region           = "ap-sydney-1"

# Choose your VM images here
# Images: https://docs.oracle.com/en-us/iaas/images/ubuntu-2004/
vm_image_ocid_x86_64 = "ocid1.image.oc1.ap-sydney-1.aaaaaaaa3jmqelz5tcnvmisee7vs5rnhsfkrtjx7cji7n7c6u3awlfhjdyaq"
vm_image_ocid_ampere = "ocid1.image.oc1.ap-sydney-1.aaaaaaaaeuykfizbpuhc6xx6irp3kpk2hybr3c34dmpolxeyc26gnc27cmrq"

# Add your SSH key here
ssh_public_key = "ssh-rsa AAAAB ..."

# Optional: Replace this with your preferred environment name
compartment_name = "homelab"
vm_name          = "homelab"
tags             = { Project = "Homelab" }
