define ifconfig($device, $changes) {
    augeas  { "$name.config" :
        context => "/files/etc/network/interfaces",
        changes => $changes,
        notify => Exec["$name.ifdown"]
    }

    exec {"$name.ifdown":
        command => "/sbin/ifconfig $device down",
        refreshonly => true, # Only execute on notification
        notify => Exec["$name.ifup"]
    }

    exec {"$name.ifup":
        command => "/sbin/ifup $device",
        refreshonly => true # Only execute on notification
    }
}

class profile::router {
    class   { "augeas": }

    ifconfig { "pub":
        device => "eth1",
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
