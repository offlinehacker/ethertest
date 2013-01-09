include radvd

class profile::router::network {
    ifconfig { "private":
        device => "eth2",
        family => "inet",
        changes => "
            set method static
            set address 10.1.0.1
            set netmask 255.255.0.0
            set network 10.1.0.0
        ",
    }

    dnsmasq::conf { 'dnsmasq':
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
        changes => "
            set method static
            set address 10.2.0.1
            set netmask 255.255.0.0
            set network 10.2.0.0
        ",
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
        changes => "
            set method static
            set address 192.168.10.1
            set netmask 255.255.255.0
            set network 192.168.10.0
        ",
    }

    ifconfig { "ext_inet6":
        device => "eth1",
        family => "inet6",
        changes => [
                "set method static",
                "set address 2001:db8:0:0::1",
                "set netmask 64",
            ],
    }

    $net = "1"
    $prod = "2"
    ifconfig::hooks { "policy_routing":
        changes => "
            set pre-up[1] 'ip route flush table $net'
            set post-up[1] 'ip route add table $net 192.168.10.0/24 dev eth1'
            set post-up[2] 'ip route add table $net default via 192.168.10.10 dev eth1'
            set post-up[3] 'ip rule add from 192.168.10.0/24 table $net'
            set post-up[4] 'ip route add table $net 10.1.0.0/16 dev eth2'
            set post-up[5] 'ip rule add from 10.1.0.0/16 table $net'
            set post-up[6] 'ip route add table $net 10.2.0.0/16 dev eth3'
            
            set pre-up[2] 'ip route flush table $prod'
            set post-up[7] 'ip route add table $prod 192.168.10.0/24 dev eth1'
            set post-up[8] 'ip route add table $prod default via 192.168.10.10 dev eth1'
            set post-up[9] 'ip route add table $prod 10.2.0.0/16 dev eth3'
            set post-up[10] 'ip rule add from 10.2.0.0/16 table $prod'


            set pre-up[3] 'ip -6 route flush table $net'
            set post-up[11] 'ip -6 route add table $net 2001:db8::/64 dev eth1'
            set post-up[12] 'ip -6 route add table $net default via 2001:db8::fffe dev eth1'
            set post-up[13] 'ip -6 rule add from 2001:db8::/64 table $net'
            set post-up[14] 'ip -6 route add table $net 2001:db8:0:1::/64 dev eth2'
            set post-up[15] 'ip -6 rule add from 2001:db8:0:1::/64 table $net'
            set post-up[16] 'ip -6 route add table $net 2001:db8:0:2::/64 dev eth3'

            set pre-up[4] 'ip -6 route flush table $prod'
            set post-up[17] 'ip -6 route add table $prod 2001:db8::/64 dev eth1'
            set post-up[18] 'ip -6 route add table $prod default via 2001:db8::fffe dev eth1'
            set post-up[19] 'ip -6 route add table $prod 2001:db8:0:2::/64 dev eth3'
            set post-up[20] 'ip -6 rule add from 2001:db8:0:2::/64 table $prod'
        "
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

class profile::router::firewall {
    package { "iptables-persistent":
        ensure => "installed"
    }

    class {"iptables::globals":
        iptables_path => "/etc/iptables/rules.v4",
        ip6tables_path => "/etc/iptables/rules.v6"
    }

    iptables::chain::filter { ["INPUT", "OUTPUT", "FORWARD"]:
        policy => "ACCEPT"
    }

    # Chain used for port forwading rules
    iptables::chain::filter { ["port_forward"]:
        policy => "-"
    }

    ip6tables::chain::filter { ["INPUT", "OUTPUT", "FORWARD"]:
        policy => "ACCEPT"
    }

    # Chain used for port forwading rules
    ip6tables::chain::filter { ["port_forward"]:
        policy => "-"
    }
   
    iptables::chain::nat { ["PREROUTING", "POSTROUTING", "INPUT", "OUTPUT"]:
        policy => "ACCEPT"
    }

    # Chain used for port forwading rules
    iptables::chain::nat { ["port_forward"]:
        policy => "-"
    }

    port_forward { "port_forward_65500":
        interface => "eth1",
        ip => "10.2.0.10",
        ip6 => "2001:db8:0:2::10",
        port => "22"
    }

    port_forward { "port_forward_80":
        interface => "eth1",
        ip => "10.2.0.10",
        ip6 => "2001:db8:0:2::10",
        port => "80"
    }

    port_forward { "port_forward_443":
        interface => "eth1",
        ip => "10.2.0.10",
        ip6 => "2001:db8:0:2::10",
        port => "443"
    }

    iptables::filter { "port_forward":
        chain => "FORWARD",
        changes => [
                "set in-interface eth1",
                "set jump port_forward",
        ],
    }

    iptables::nat { "port_forward":
        chain => "PREROUTING",
        changes => [
                "set in-interface eth1",
                "set jump port_forward",
        ],
    }

    ip6tables::filter { "port_forward":
        chain => "FORWARD",
        changes => [
                "set in-interface eth1",
                "set jump port_forward",
        ],
    }

    # Enable masquerading for server behind nat
    iptables::nat { "masquerade":
        chain => "POSTROUTING",
        changes => [
                "set out-interface eth1",
                "set jump MASQUERADE",
        ],
    }

    # Enable related and establised connections to outside
    iptables::filter { "accept_established":
        chain => "FORWARD",
        changes => [
                "set out-interface eth1",
                "set match[ . = 'state'] state",
                "set state 'ESTABLISHED,RELATED'",
                "set jump ACCEPT",
        ],
        require => [Iptables::Filter["port_forward"]]
    }

    # Enable related and establised connections to outside
    ip6tables::filter { "accept_established":
        chain => "FORWARD",
        changes => [
                "set out-interface eth1",
                "set match[ . = 'state'] state",
                "set state 'ESTABLISHED,RELATED'",
                "set jump ACCEPT",
        ],
        require => [Ip6tables::Filter["port_forward"]]
    }
}

class profile::router {
    class   { "augeas": }

    class { "profile::router::network": }

    class { "profile::router::firewall": 
        require => Class["profile::router::network"]
    }
}

include profile::router
