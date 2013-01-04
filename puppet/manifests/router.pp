include radvd

class profile::router {
    class   { "augeas": }

    ifconfig { "private":
        device => "eth2",
        family => "inet",
        changes => [
                "set method static",
                "set address 10.1.0.1",
                "set netmask 255.255.0.0",
                "set network 10.1.0.0",
            ],
    }

    dnsmasq::conf { 'another-config':
        ensure  => present,
        content => 'dhcp-range=10.1.0.10,10.1.0.253,12h',
    }

    ifconfig { "private_inet6":
        device => "eth2",
        family => "inet6",
        changes => [
                "set method static",
                "set address 2001:db8:0:1::1",
                "set netmask 64",
            ],
    }

    radvd::interface { 'eth2':
        options => {
            'AdvSendAdvert'     => 'on',
            'MinRtrAdvInterval' => 10,
            'MaxRtrAdvInterval' => 30,
        },
        prefixes => {
            '2001:db8:0:1::/64' => {
            'AdvOnLink'     => 'on',
            'AdvAutonomous' => 'on',
            },
        },
    }

    ifconfig { "prod":
        device => "eth3",
        family => "inet",
        changes => [
                "set method static",
                "set address 10.2.0.1",
                "set netmask 255.255.0.0",
                "set network 10.2.0.0",
            ],
    }

    ifconfig { "prod_inet6":
        device => "eth3",
        family => "inet6",
        changes => [
                "set method static",
                "set address 2001:db8:0:2::1",
                "set netmask 64",
            ],
    }

    ifconfig { "ext":
        device => "eth1",
        family => "inet",
        changes => [
                "set method static",
                "set address 192.168.10.1",
                "set netmask 255.255.255.0",
                "set network 192.168.10.0",
            ],
    }

    ifconfig { "ext_inet6":
        device => "eth1",
        family => "inet6",
        changes => [
                "set method static",
                "set address 2001:db8::1",
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

include profile::router
