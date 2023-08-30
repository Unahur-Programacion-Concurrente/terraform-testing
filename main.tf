terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = ">=2.7.4"
    }
  }
}

provider "proxmox" {
  # url is the hostname (FQDN if you have one) for the proxmox host you'd like to connect to to issue the commands. my proxmox host is 'prox-1u'. Add /api2/json at the end for the API
  pm_api_url = "https://192.168.0.217:8006/api2/json"
  # api token id is in the form of: <username>@pam!<tokenId>
  pm_api_token_id = "dbuaon@pam!dbuaon_id"
  # this is the full secret wrapped in quotes. don't worry, I've already deleted this from my proxmox cluster by the time you read this post
  pm_api_token_secret = "a6651eea-4bcd-4d7b-a564-2515902aa694"
  # leave tls_insecure set to true unless you have your proxmox SSL certificate situation fully sorted out (if you do, you will know)
  pm_tls_insecure = true
  pm_log_enable       = true
  pm_log_file         = "terraform-plugin-proxmox.log"
  pm_log_levels = {
    _default    = "debug"
    _capturelog = ""
  }
}


resource "proxmox_vm_qemu" "virtual_machines" {
    for_each = var.virtual_machines
    name = each.value.hostname
    target_node = each.value.target_node
    clone = "ubuntu-20.04-cloudimg"
    full_clone = true
    ciuser = "ubuntu"
    cipassword = "unahur"
    agent = 1
    os_type = "cloud-init"
    qemu_os = "other"
    cores = each.value.cpu_cores
    sockets = each.value.cpu_sockets
    cpu = "host"
    memory = each.value.memory
    scsihw = "virtio-scsi-pci"
    bootdisk = "scsi0"
    define_connection_info = false
#   ipconfig0 = "ip=dhcp"
    ipconfig0 = "ip=${each.value.ip_address}/${each.value.cidr},gw=${each.value.gateway}"
    nameserver = each.value.dns
    disk {
        size = "12492M"
        type = "scsi"
        storage = "local-lvm"
    }
    disk {
        size = "4G"
        type = "scsi"
        storage = "local-lvm"
    }
    network {
          bridge = "vmbr0"
          firewall = false
          link_down = false
          model     = "virtio"
          mtu       = 0
          queues    = 0
          rate      = 0
          tag       = -1
        } 
    network {
          bridge = "vmbr1"
          firewall = false
          link_down = false
          model     = "virtio"
          mtu       = 0
          queues    = 0
          rate      = 0
          tag       = -1
        } 
        
    lifecycle {
          ignore_changes = [
     #      network,
        ]
     }
}