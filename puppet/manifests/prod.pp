class profile::prod {
    class   { "augeas": }

    ifconfig { "prod":
        device => "eth1",
        family => "inet",
        changes => [
                "set method static",
                "set address 10.3.0.2",
                "set netmask 255.255.255.0",
                "set network 10.3.0.0",
            ],
    }

    ifconfig { "prod_inet6":
        device => "eth1",
        family => "inet6",
        changes => [
                "set method static",
                "set address 2001:db8:0:3::2",
                "set netmask 64",
            ],
    }

    sysctl { "net.ipv4.ip_forward":
        ensure  => present,
        value   => "1",
        comment => "Enable ipv4 forwarding",
    }

    sysctl { "net.ipv6.conf.all.forwarding":
        ensure  => present,
        value   => "1",
        comment => "Enable ipv6 forwarding",
    }

}

include profile::prod
