class profile::loophole::iptables {
    class {"iptables::globals": }

    iptables::chain::filter { ["INPUT", "OUTPUT", "FORWARD"]:
        policy => "ACCEPT"
    }

    iptables::chain::nat { ["PREROUTING", "POSTROUTING", "INPUT", "OUTPUT"]:
        policy => "ACCEPT"
    }

    iptables::nat { "loophole_to_victim":
        chain => "PREROUTING",
        changes => [
                "set protocol tcp",
                "set destination 192.168.10.5/32",
                "set match[. = 'tcp'] tcp",
                "set dport 90",
                "set jump NETMAP",
                "set to 192.168.10.6/32",
        ],
    }

    iptables::nat { "loophole_to_victim2":
        chain => "PREROUTING",
        changes => [
                "set protocol tcp",
                "set destination 192.168.10.5/32",
                "set match[. = 'tcp'] tcp",
                "set dport 80",
                "set jump NETMAP",
                "set to 192.168.10.6/32",
        ],
        require => [Iptables::Nat["loophole_to_victim"],]
    }

    iptables::nat { "loophole_to_victim3":
        chain => "PREROUTING",
        changes => [
                "set protocol tcp",
                "set destination 192.168.10.5/32",
                "set match[. = 'tcp'] tcp",
                "set dport 80",
                "set jump NETMAP",
                "set to 192.168.10.6/32",
        ],
        require => [Iptables::Nat["loophole_to_victim2"],]
    }

    iptables::filter { "loophole_to_victim4":
        chain => "INPUT",
        changes => [
                "set protocol tcp",
                "set destination 192.168.10.5/32",
                "set match[. = 'tcp'] tcp",
                "set dport 100",
                "set jump DROP",
        ],
    }

}

class profile::loophole {
    class   { "augeas": }

    ifconfig { "pub":
        device => "eth1",
        family => "inet",
        changes => [
                "set method static",
                "set address 192.168.10.5",
                "set netmask 255.255.255.0",
                "set network 192.168.10.0",
                "set gateway 192.168.10.1",
            ],
    }

    class { "profile::loophole::iptables":
        require => [Ifconfig["pub"], Class["augeas"]]
    }

    file { "/etc/iptables-save":
        audit => content,
        require => Class["profile::loophole::iptables"],
    }

    service { "iptables-persistent":
        ensure  => running,
        enable  => true,
        subscribe => File["/etc/iptables-save"]
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

include profile::loophole
