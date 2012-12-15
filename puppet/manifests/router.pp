class profile::router {
    class   { "augeas": }
    augeas  { "pub" :
        context => "/files/etc/network/interfaces",
        changes => [
            "set auto[child::1 = 'eth1']/1 eth1",
            "set iface[. = 'eth1'] eth1",
            "set iface[. = 'eth1']/family inet",
            "set iface[. = 'eth1']/method static",
            "set iface[. = 'eth1']/address 192.168.10.2",
            "set iface[. = 'eth1']/netmask 255.255.255.0",
            "set iface[. = 'eth1']/network 192.168.10.0",
            "set iface[. = 'eth1']/gateway 192.168.10.1",
        ],
    }
}

include profile::router
