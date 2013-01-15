==============================================
Standard corporate linux network configuration
==============================================

This is example linux network configuration using standard corporate network
topology.

--------------------------------------------
Networks and their respective configurations
--------------------------------------------

_______________
Private network
_______________

  This network emulates a typical managed company in company with dynamically assigned
  IPs.

  .. note::

    :download:`Configuration file download <../puppet/manifests/priv.pp>`.

  ::

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

  Connected to the router's 'eth2' interface

__________________
Production network
__________________

  This network emulates a production server with static IPs

  .. note::

    :download:`Configuration file download <../puppet/manifests/prod.pp>`.

  ::

    ifconfig { "prod":
        device => "eth1",
        family => "inet",
        changes => [
                "set method static",
                "set address 10.2.0.10",
                "set netmask 255.255.255.0",
                "set network 10.2.0.0",
                "set gateway 10.2.0.1"
            ],
    }

    ifconfig { "prod_inet6":
        device => "eth1",
        family => "inet6",
        changes => [
                "set method static",
                "set address 2001:db8:0:2::10",
                "set netmask 64",
                "set gateway 2001:db8:0:2::1",
            ],
    }
  

  Connected to the router's 'eth3' interface

__________
The router
__________

  This emulates a router, in this case a linux system serving as a router

  .. note::

    :download:`Configuration file download <../puppet/manifests/router.pp>`.

  * Network configuration::

    include radvd

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

  * IPSec configuration::

    class { "ipsec::base": }

    ipsec::peer{ "prod":
        policy_level => "require",
        local_ip => "2001:db8:0:2::1",
        peer_ip => "2001:db8:0:2::10",
        localnet => "::/0", 
        remotenet => "2001:db8:0:2::10",
        encap => "tunnel",
        authmethod => "psk",
        psk => "test"
    }

  This :term:`IPSec` configuration encrypts all trafic to peer 2001:db8:0:2::10
  throught :term:`IPSec` tunnel.

  * Secure policy based routing configuration::

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

            set pre-up[4] 'ip -6 route flush table $prod'
            set post-up[17] 'ip -6 route add table $prod 2001:db8::/64 dev eth1'
            set post-up[18] 'ip -6 route add table $prod default via 2001:db8::fffe dev eth1'
            set post-up[19] 'ip -6 route add table $prod 2001:db8:0:2::/64 dev eth3'
            set post-up[20] 'ip -6 rule add from 2001:db8:0:2::/64 table $prod'
        "
    }

  This policy based routing defines static routes that are devided in two segments
  net and production. This allows to have another layer of security where we don't
  allow routing from production to private environment. The main routing table is
  used for managment.

  * Firewall configuration::

   class router::firewall {
        package { "iptables-persistent":
            ensure => "installed"
        }

        class {"iptables::globals":
            iptables_path => "/etc/iptables/rules.v4",
            ip6tables_path => "/etc/iptables/rules.v6"
        }

    [...]

        # Chain used for port forwading rules
        iptables::chain::nat { ["port_forward"]:
            policy => "-"
        }

        ip6tables::chain::filter { ["INPUT", "OUTPUT", "FORWARD"]:
            policy => "DROP"
        }

        iptables::chain::nat { ["PREROUTING", "POSTROUTING", "INPUT", "OUTPUT"]:
            policy => "ACCEPT"
        }

    [...]

    class router::firewall::ext {
        require("router::firewall")

        # Chain used for port forwading rules
        ip6tables::chain::filter { ["ext_icmpv6"]:
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

        [...] 
