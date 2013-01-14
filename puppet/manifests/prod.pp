class profile::prod {
    class   { "augeas": }

    ifconfig { "prod":
        device => "eth1",
        family => "inet",
        changes => [
                "set method static",
                "set address 10.2.0.10",
                "set netmask 255.255.255.0",
                "set network 10.2.0.0",
            ],
    }

    ifconfig { "prod_inet6":
        device => "eth1",
        family => "inet6",
        changes => [
                "set method static",
                "set address 2001:db8:0:2::10",
                "set netmask 64",
            ],
    }

    $net = "1"
    $prod = "2"
    ifconfig::hooks { "policy_routing":
        changes => "
            set pre-up[1] 'ip route flush table $prod'
            set post-up[1] 'ip route add table $prod default via 10.2.0.1 dev eth1'
            set post-up[2] 'ip route add table $prod 10.2.0.0/16 dev eth1'
            set post-up[3] 'ip rule add to 10.2.0.0/16 table $prod'

            set pre-up[2] 'ip -6 route flush table $prod'
            set post-up[4] 'ip -6 route add table $prod default via 2001:db8:0:2::1 dev eth1'
            set post-up[5] 'ip -6 route add table $prod 2001:db8:0:2::/64 dev eth1'
            set post-up[6] 'ip -6 rule add to 2001:db8:0:2::/64 table $prod'
        "
    }

    class { "ipsec::base": }

    ipsec::peer{ "prod":
        policy_level => "require",
        local_ip => "2001:db8:0:2::10",
        peer_ip => "2001:db8:0:2::1",
        localnet => "2001:db8:0:2::10",
        remotenet => "::/0", 
        encap => "tunnel",
        authmethod => "psk",
        psk => "test",
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
