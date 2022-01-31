# Home Lab on the Oracle Cloud Infrastructure (OCI)

This Terraform plan builds a virtual home lab environment on the Oracle Cloud
Infrastructure (OCI) within the [always free](https://www.oracle.com/cloud/free/)
limits.

[!["Buy Me A Coffee"](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://www.buymeacoffee.com/gbraad)

## About the project

The following resources are deployed within the free-tier offer:

- 2x **VM.Standard.E2.1.Micro** instances (1 OCPU, 1 GB RAM, x86_64);
- 1x **VM.Standard.A1.Flex** instance (4 OCPU, 24 GB RAM, aarch64);
- An additional **59 GB volume** attached to the _VM.Standard.A1.Flex_ instance;
- A **volume backup policy** taking one automatic snapshot per week (retained for
  5 weeks); and
- Reasonably sane configuration settings.

## Requirements

- Terraform v1.1.0 (or higher) installed on your PC/Mac;
- An Oracle Cloud Infrastructure (OCI) account;
- An SSH public-private key pair; and
- Basic knowledge of the Linux command line.

## Configuration

1. In order to deploy your home lab environment with Terraform, clone or download
   this repository to your computer.

1. Follow the
   [instructions at Oracle](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/terraformproviderconfiguration.htm#configuring_the_terraform_provider)
   to get these configuration parameters for the
   [terraform.tfvars](./terraform/terraform.tfvars) configuration file:

   - `tenancy_oid`
   - `user_ocid`
   - `private_key_path`
   - `fingerprint`
   - `region`

1. Depending on your chosen `region`, retrieve the image ID from
   [this page](https://docs.oracle.com/en-us/iaas/images/) for your instances.

   - Choose any of your preferred images (e.g. Ubuntu, CentOS) for the
     **VM.Standard.E2.1.Micro** instances.
   - Choose the `aarch64` variation of Ubuntu 20.04, Oracle Linux 7.x or Oracle
     Linux 8.x Linux distributions for the **VM.Standard.A1.Flex** instance.

1. Replace `vm_image_ocid_x86_64` in
   [terraform.tfvars](./terraform/terraform.tfvars) with your chosen image ID for
   the **VM.Standard.E2.1.Micro** instance.

1. Replace `vm_image_ocid_ampere` in
   [terraform.tfvars](./terraform/terraform.tfvars) with your chosen image ID for
   the **VM.Standard.A1.Flex** instance.

1. Add your SSH public key to the `ssh_authorized_keys` configuration parameter
   in [terraform.tfvars](./terraform/terraform.tfvars)

## Deployment

Once your [terraform.tfvars](./terraform/terraform.tfvars) is complete, your new
home lab environment is ready for deployment.

1. Run Terraform init first:

   ```sh
   terraform init
   ```

1. Build a Terraform plan:

   ```sh
   terraform plan -out=tfplan
   ```

1. Deploy your home lab environment:

   ```sh
   terraform apply "tfplan"
   ```

Congratulations! Your VMs are ready to use. Check the following section for your
login details.

## Where to go from here

- Navigate to the
  [Instances page on the OCI dashboard](https://cloud.oracle.com/compute/instances)
  to obtain the sign-in details of your new virtual instances.

- Partition, format and mount the additional 59 GB large `/dev/sdb` volume on
  your **VM.Standard.A1.Flex** instance.

- Install all security updates on your new instances.

- Only port `tcp/22` is open to the internet by default. If you need to allow
  further ports, modify the
  [network-subnet-public.tf](./terraform/network-subnet-public.tf) file to your
  liking. If you have `iptables` or similar running on your instance, you may
  need to change your firewall settings on the instance, too.

- Explore the other OCI [free tier](https://www.oracle.com/cloud/free/) services
  as well.

- Refer to the project ideas if you have some free capacity on your instances.

## Project ideas

As Oracle is providing a generous amount of free egress traffic
([10 TB/month](https://www.oracle.com/cloud/networking/networking-pricing.html)),
it is reasonable to run the following services for the community and yourself on
the free tier:

- Contribute to computing tasks with the
  [BOINC client](https://boinc.berkeley.edu/projects.php);
- Operate a
  [Tor relay](https://community.torproject.org/relay/setup/guard/debian-ubuntu/);
- Run the
  [Archive Team Warrior](https://wiki.archiveteam.org/index.php/ArchiveTeam_Warrior)
  internet archiving appliance;
- [Audit WPA handshakes](https://wpa-sec.stanev.org/) with
  [help_crack.py](https://wpa-sec.stanev.org/hc/help_crack.py);
- Operate a
  [Syncthing relay server](https://docs.syncthing.net/users/strelaysrv.html);
- Run a BitTorrent server seeding Linux ISOs back to the open-source community.
- Run a [Honeypot](https://www.projecthoneypot.org/);
- Run a private VPN server;
- Host your own Unifi Controller;
- Run your own [Pi-Hole](https://pi-hole.net/) or [AdGuard](https://adguard.com/)
  service;
- Host your own PBX for your VoIP phones;
- Get more ideas at [/r/selfhosted](https://www.reddit.com/r/selfhosted/) and
  [awesome-selfhosted/awesome-selfhosted](https://github.com/awesome-selfhosted/awesome-selfhosted);
  or
- Receive community support from the
  [/r/oraclecloud](https://www.reddit.com/r/oraclecloud) subreddit.
