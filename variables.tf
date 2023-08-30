variable "virtual_machines" {
    type = map 
        default = {
            lab1 = {
                hostname = "lab-1"
                target_node = "pve"
                cpu_cores = 1
                cpu_sockets = 1
                memory = 2048
                ip_address = "192.168.0.36"
                cidr = "24"
                gateway = "192.168.0.1"
                dns = "192.168.0.1"
            }
            lab2 = {
                hostname = "lab-2"
                target_node = "pve"
                cpu_cores = 1
                cpu_sockets = 1
                memory = 2048
                ip_address = "192.168.0.160"
                cidr = "24"
                gateway = "192.168.0.1"
                dns = "192.168.0.1"
            } 
            lab3 = {
                hostname = "lab-3"
                target_node = "pve"
                cpu_cores = 1
                cpu_sockets = 1
                memory = 2048
                ip_address = "192.168.0.214"
                cidr = "24"
                gateway = "192.168.0.1"
                dns = "192.168.0.1"
            }
        }
}