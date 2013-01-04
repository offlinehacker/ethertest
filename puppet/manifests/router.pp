define ifconfig($device, $family, $changes, ) {
    $ch =   [
                "set auto[child::1 = '$device']/1 $device",
                "set iface[last()+1] $device",
                "set iface[last()]/family $family",
                "set iface[last()]/method static",
                ]
    notice($ch)
    augeas  { "ifconfig.$name.add" :
        context => "/files/etc/network/interfaces",
        changes => $ch,
        onlyif => ["match iface[ . = '$device' and family ='$family'] size==0"]
    }

    augeas  { "ifconfig.$name" :
        context => "/files/etc/network/interfaces/iface[ . = '$device' and family = '$family']",
        changes =>  $changes,
        notify => Exec["$name.ifdown"],
        require => Augeas["ifconfig.$name.add"]
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
        family => "inet",
        changes => [
                "set method static",
                "set address 192.168.10.2",
                "set netmask 255.255.255.0",
                "set network 192.168.10.0",
                "set gateway 192.168.10.1",
            ],
    }

    ifconfig { "pubi_inet6":
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
