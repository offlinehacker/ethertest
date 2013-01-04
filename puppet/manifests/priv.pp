class profile::private {
    class   { "augeas": }

    ifconfig { "private":
        device => "eth1",
        family => "inet",
        changes => [
                "set method dhcp",
            ],
    }

    ifconfig { "private_inet6":
        device => "eth1",
        family => "inet6",
        changes => [
                "set method auto",
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

include profile::private
