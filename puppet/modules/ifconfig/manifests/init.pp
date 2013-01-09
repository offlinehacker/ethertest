define ifconfig::hooks($changes){
    augeas  { "ifconfig.hooks.$name.edit" :
        context => "/files/etc/network/interfaces/iface[last()]",
        changes =>  $changes,
        notify => Service["networking"],
        lens => "Interfaces.lns",
        incl => "/etc/network/interfaces"
    }

    service { "networking":
        ensure  => "running",
        enable  => "true",
        require => Augeas["ifconfig.hooks.$name.edit"],
    }
}

define ifconfig($device, $family, $changes, ) {
    augeas  { "ifconfig.$name.add" :
        context => "/files/etc/network/interfaces",
        changes =>  [
                "set auto[child::1 = '$device']/1 $device",
                "set iface[last()+1] $device",
                "set iface[last()]/family $family",
                "set iface[last()]/method static",
                ],
        onlyif => ["match iface[ . = '$device' and family ='$family'] size==0"],
        lens => "Interfaces.lns",
        incl => "/etc/network/interfaces"
    }

    augeas  { "ifconfig.$name" :
        context => "/files/etc/network/interfaces/iface[ . = '$device' and family = '$family']",
        changes =>  $changes,
        notify => Exec["$name.ifdown"],
        require => Augeas["ifconfig.$name.add"],
        lens => "Interfaces.lns",
        incl => "/etc/network/interfaces"
    }

    exec {"$name.ifdown":
        command => "/sbin/ifdown $device",
        refreshonly => true, # Only execute on notification
        notify => Exec["$name.ifup"]
    }

    exec {"$name.ifup":
        command => "/sbin/ifup $device",
        refreshonly => true # Only execute on notification
    }
}
