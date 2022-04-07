resource "proxmox_vm_qemu" "moose-one" {
  name        = "moose-one-iac"
  target_node = "bender"
  clone = "ubuntu-cloud-shared"
  #vmid = 0

  sockets = 2
  cores = 9
  memory = 18432

  nameserver = "10.1.2.120"
  ipconfig0 = "gw=10.1.2.1,ip=10.1.2.200/24"

  #agent = 1

  disk {
    type         = "virtio"
    storage      = "local-lvm"
    size         = "128G"
  }
}

resource "local_file" "ansible_inventory" {
  filename = "../ansible/inventory.ini"
  content = split("/", substr(proxmox_vm_qemu.moose-one.ipconfig0, 15, 18))[0]
}
