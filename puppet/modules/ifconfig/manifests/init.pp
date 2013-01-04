define ifconfig($device, $family, $changes, ) {
    augeas  { "ifconfig.$name.add" :
        context => "/files/etc/network/interfaces",
        changes =>  [
                "set auto[child::1 = '$device']/1 $device",
                "set iface[last()+1] $device",
                "set iface[last()]/family $family",
                "set iface[last()]/method static",
                ],
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
