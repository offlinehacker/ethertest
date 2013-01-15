====================
IPSec configurations
====================

Here is a collections of different working IPSec configurations.

.. todo::

    * Add description how IPSec works

-------------------------------------------
Linux IPSec encryped lan(with IPv6 support)
-------------------------------------------

There might be a question why somebody would want to encrypt traffic in LAN.
Well it turns out that IPSec can easyily protect you against the attacker that
have capability to infiltrate inside your LAN or the one that will compromise
one of your production machines and will want to manipulate traffic betwene
machines. As we know from :doc:`ipv6_security` it's pretty easy to sniff and 
manipulate traffic on switched LAN, but if traffic is encrypted that becomes
impossible, or very very hard.

Linux kernel has already integrated :term:`IPSec` support, but you need a client
to initiate :term:`IPSec` sessions.

First you have to install two packages:

* ipsec-tools

* racoon

Ipsec-tools has several utils, more specifficly:

* setkey 
  Tool to manipulate and dump the kernel Security Policy Database (SPD) and 
  Security Association Database (SAD).

* racoon
  Internet Key Exchange (IKE) daemon for automatically keying IPsec connections.

* racoonctl
  A shell-based control tool for racoon.

Imageine we have the following netwok topology:

... and we want to make an ipsec tunnel betwene every hosts in production and
router.

So here is requierd router :term:`IPSec` configuration::

    # setkey configuration
    vagrant@router:~$ cat /etc/ipsec-tools.conf 
    #!/usr/sbin/setkey -f

    flush;
    spdflush;

    # Filter NDP traffic
    spdadd ::/0 ::/0 icmp6 135,0 -P out none;
    spdadd ::/0 ::/0 icmp6 135,0 -P in none;
    spdadd ::/0 ::/0 icmp6 136,0 -P out none;
    spdadd ::/0 ::/0 icmp6 136,0 -P in none;

    # Traffic that we want to encrypt
    spdadd ::/0 2001:db8:0:2::10 any -P out ipsec
            esp/tunnel/2001:db8:0:2::1-2001:db8:0:2::10/require;
    # Traffic that gets decrypted
    spdadd 2001:db8:0:2::10 ::/0 any -P in ipsec
            esp/tunnel/2001:db8:0:2::10-2001:db8:0:2::1/require;

    # racoon configuration
    vagrant@router:~$ cat /etc/racoon/peers.d/prod.conf 
    remote 2001:db8:0:2::10 {
            exchange_mode main;

            proposal {
                    encryption_algorithm aes 256;
                    hash_algorithm sha1;
                    authentication_method pre_shared_key;
                    dh_group 5;
            }
    }

    sainfo address ::/0 any address 2001:db8:0:2::10 any {
            pfs_group 5;
            encryption_algorithm aes 256;
            authentication_algorithm hmac_sha1;
            compression_algorithm deflate;
    }

    # configuration of pre-shared keys
    vagrant@prod:~$ sudo cat /etc/racoon/psk.txt 
    2001:db8:0:2::10 test

And requierd host :term:`IPSec` configuration::

    # setkey configuration
    vagrant@prod:~$ cat /etc/ipsec-tools.conf 
    #!/usr/sbin/setkey -f

    flush;
    spdflush;

    # Filter NDP traffic
    spdadd ::/0 ::/0 icmp6 135,0 -P out none;
    spdadd ::/0 ::/0 icmp6 135,0 -P in none;
    spdadd ::/0 ::/0 icmp6 136,0 -P out none;
    spdadd ::/0 ::/0 icmp6 136,0 -P in none;

    # Traffic that we want to encrypt
    spdadd 2001:db8:0:2::10 ::/0 any -P out ipsec
            esp/tunnel/2001:db8:0:2::10-2001:db8:0:2::1/require;
    # Traffic that gets decrypted
    spdadd ::/0 2001:db8:0:2::10 any -P in ipsec
            esp/tunnel/2001:db8:0:2::1-2001:db8:0:2::10/require;

    
    # racoon configuration
    vagrant@prod:~$ cat /etc/racoon/peers.d/prod.conf
    remote 2001:db8:0:2::1 {
            exchange_mode main;

            proposal {
                    encryption_algorithm aes 256;
                    hash_algorithm sha1;
                    authentication_method pre_shared_key;
                    dh_group 5;
            }
    }

    sainfo address 2001:db8:0:2::10 any address ::/0 any {
            pfs_group 5;
            encryption_algorithm aes 256;
            authentication_algorithm hmac_sha1;
            compression_algorithm deflate;
    }

    # configuration of pre-shared keys
    vagrant@prod:~$ sudo cat /etc/racoon/psk.txt 
    2001:db8:0:2::1 test

Configuration is self explanatory, and as we can see router's configuration is
just the reverse of host configuration.

.. note::

    I did not manage to get :term:`IPSec` working in transport mode, which is quite
    logical the way :term:`IPSec` is implemented. Still i tried.

If we ping host from router or anywhere from another network, we can see encrypted
data::

    vagrant@router:~$ sudo tcpdump -i eth3    
    16:28:25.270371 IP6 2001:db8:0:2::1 > 2001:db8:0:2::10: ESP(spi=0x0f812e62,seq=0x1f), length 148
    16:28:25.281231 IP6 2001:db8:0:2::10 > 2001:db8:0:2::1: ESP(spi=0x04f948d3,seq=0x1f), length 148
    16:28:25.281231 IP6 2001:db8:0:2::10 > 2001:db8::fffe: ICMP6, echo reply, seq 15, length 64

That's an indicator that :term:`IPSec` works.

.. todo::

    * Add ipv4 configuration
