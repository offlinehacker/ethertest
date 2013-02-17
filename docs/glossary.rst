========
Glossary
========

.. tabularcolumns:: | p{1cm} | p{4cm} | p{1cm} | p{9cm} |


.. glossary::

    ICMPv6 types
        Types of ICMPv6 messages

        +----------------------------------------------+--------------------------------------------------------------------+
        | Type                                         | Code                                                               |
        +---------+------------------------------------+-------+------------------------------------------------------------+
        | Value   | Meaning                            | Value | Meaning                                                    |
        +---------+------------------------------------+-------+------------------------------------------------------------+
        |                                  ICMPv6 Error Messages                                                            |
        +---------+------------------------------------+-------+------------------------------------------------------------+
        |    1    | Destination Unreachable            |   0   | no route to destination                                    |
        |         |                                    |       |                                                            |
        |         |                                    |   1   | communication with destination administratively prohibited |
        |         |                                    |       |                                                            |
        |         |                                    |   2   | beyond scope of source address                             |
        |         |                                    |       |                                                            |
        |         |                                    |   3   | address unreachable                                        |
        |         |                                    |       |                                                            |
        |         |                                    |   4   | port unreachable                                           |
        |         |                                    |       |                                                            |
        |         |                                    |   5   | source address failed ingress/egress policy                |
        |         |                                    |       |                                                            |
        |         |                                    |   6   | reject route to destination                                |
        |         |                                    |       |                                                            |
        |         |                                    |   7   | Error in Source Routing Header                             |
        +---------+------------------------------------+-------+------------------------------------------------------------+
        |    2    | Packet too big                     |   0   |                                                            |
        +---------+------------------------------------+-------+------------------------------------------------------------+
        |    3    | Time Exceeded                      |   0   | hop limit exceeded in transit                              |
        |         |                                    |       |                                                            |
        |         |                                    |   1   | fragment reassembly time exceeded                          |
        +---------+------------------------------------+-------+------------------------------------------------------------+
        |    4    | Parameter Problem                  |   0   | erroneous header field encountered                         |
        |         |                                    |       |                                                            |
        |         |                                    |   1   | unrecognized Next Header type encountered                  |
        |         |                                    |       |                                                            |
        |         |                                    |   2   | unrecognized IPv6 option encountered                       |
        +---------+------------------------------------+-------+------------------------------------------------------------+
        |    100  | Private experimentation            |       |                                                            |
        +---------+------------------------------------+-------+------------------------------------------------------------+
        |    101  | Private experimentation            |       |                                                            |
        +---------+------------------------------------+-------+------------------------------------------------------------+
        |    127  | Reserved                           |       |                                                            |
        +---------+------------------------------------+-------+------------------------------------------------------------+
        |                                  ICMPv6 Informational Messages                                                    |
        +---------+------------------------------------+-------+------------------------------------------------------------+
        |    128  | Echo request                       |   0   |                                                            |
        +---------+------------------------------------+-------+------------------------------------------------------------+
        |    129  | Echo reply                         |   0   |                                                            |
        +---------+------------------------------------+-------+------------------------------------------------------------+
        |    130  | Multicast listener query           |   0   | General Query and Multicast-Address-Specific Query         |
        +---------+------------------------------------+-------+------------------------------------------------------------+
        |    131  | Multicast Listener Report          |   0   |                                                            |
        +---------+------------------------------------+-------+------------------------------------------------------------+
        |    132  | Multicast Listener Done            |   0   |                                                            |
        +---------+------------------------------------+-------+------------------------------------------------------------+
        |    133  | Router Solicitation (NDP)          |   0   |                                                            |
        +---------+------------------------------------+-------+------------------------------------------------------------+
        |    134  | Router Advertisement (NDP)         |   0   |                                                            |
        +---------+------------------------------------+-------+------------------------------------------------------------+
        |    135  | Neighbor Solicitation (NDP)        |   0   |                                                            |
        +---------+------------------------------------+-------+------------------------------------------------------------+
        |    136  | Neighbor Advertisement (NDP)       |   0   |                                                            |
        +---------+------------------------------------+-------+------------------------------------------------------------+
        |    137  | Redirect Message (NDP)             |   0   |                                                            |
        +---------+------------------------------------+-------+------------------------------------------------------------+
        |    138  | Router Renumbering                 |   0   | Router Renumbering Command                                 |
        |         |                                    |       |                                                            |
        |         |                                    |   1   | Router Renumbering Result                                  |
        |         |                                    |       |                                                            |
        |         |                                    |   255 | Sequence Number Reset                                      |
        +---------+------------------------------------+-------+------------------------------------------------------------+
        |    139  | ICMP Node Information Query        |   0   | Contains IPv6 address which is the Subject of this Query   |
        |         |                                    |       |                                                            |
        |         |                                    |   1   | Contains name which is the Subject of this Query           |
        |         |                                    |       |                                                            |
        |         |                                    |   2   | Contains IPv4 address which is the Subject of this Query   |
        +---------+------------------------------------+-------+------------------------------------------------------------+
        |    140  | CMP Node Information Response      |   0   | A successful reply                                         |
        |         |                                    |       |                                                            |
        |         |                                    |   1   | The Responder refuses to supply the answer                 |
        |         |                                    |       |                                                            |
        |         |                                    |   2   | The Qtype of the Query is unknown to the Responder         |
        +---------+------------------------------------+-------+------------------------------------------------------------+
        |    141  | Inverse ND Solicitation Message    |   0   |                                                            |
        +---------+------------------------------------+-------+------------------------------------------------------------+
        |    142  | Inverse ND Advertisement Message   |   0   |                                                            |
        +---------+------------------------------------+-------+------------------------------------------------------------+
        |    143  | MLDv2 reports                      |       |                                                            |
        +---------+------------------------------------+-------+------------------------------------------------------------+
        |    144  | Home agent Address Discovery Req.  |   0   |                                                            |
        +---------+------------------------------------+-------+------------------------------------------------------------+
        |    145  | Home Agent Address Discovery Reply |   0   |                                                            |
        +---------+------------------------------------+-------+------------------------------------------------------------+
        |    146  | Mobile Prefix Solicitation         |   0   |                                                            |
        +---------+------------------------------------+-------+------------------------------------------------------------+
        |    147  | Mobile Prefix Advertisement        |   0   |                                                            |
        +---------+------------------------------------+-------+------------------------------------------------------------+
        |    148  | Certification Path Solicitation    |       |                                                            |
        +---------+------------------------------------+-------+------------------------------------------------------------+
        |    149  | Certification Path Advertisement   |       |                                                            |
        +---------+------------------------------------+-------+------------------------------------------------------------+
        |    150  | Multicast Router Advertisement     |       |                                                            |
        +---------+------------------------------------+-------+------------------------------------------------------------+
        |    151  | Multicast Router Solicitation      |       |                                                            |
        +---------+------------------------------------+-------+------------------------------------------------------------+
        |    152  | Multicast Router Solicitation      |       |                                                            |
        +---------+------------------------------------+-------+------------------------------------------------------------+
        |    155  | RPL Control Message                |       |                                                            |
        +---------+------------------------------------+-------+------------------------------------------------------------+
        |    200  | Private experimentation            |       |                                                            |
        +---------+------------------------------------+-------+------------------------------------------------------------+
        |    201  | Private experimentation            |       |                                                            |
        +---------+------------------------------------+-------+------------------------------------------------------------+
        |    255  | Reserved                           |       |                                                            |
        +---------+------------------------------------+-------+------------------------------------------------------------+

    Redirect message
        Because of the different roles of routers and hosts in an IPv6 internetwork,i
        hosts don't need to know very much about routes. They send datagrams 
        intended for destinations on the local network directly, while those for 
        other networks they dump to their local routers and let them “do the driving”, 
        so to speak.

        If a local network has only a single router, then it will send all such 
        non-local traffic to that router. If it has more than one local router, 
        the host then must decide which router to use for which traffic. 
        In general terms, a host will not know the most 
        efficient choice of router for every type of datagram it may need to send. 
        In fact, many nodes start out with a limited routing table that says to 
        send everything to a single default router, even if there are several 
        routers on the network.

        When a router receives datagrams destined for certain networks, it may 
        realize that it would be more efficient if such traffic was sent by a 
        host to a different router on the local network. If so, it will invoke 
        the Redirect function by sending an ICMPv6 Redirect message to the device 
        that sent the original datagram. This is the last of the functions that 
        in IPv6 are performed by the :term:`Neighbor Discovery ``
        protocol, and is explained in a topic on the Redirect function in that 
        section. Redirect messages are always sent unicast to the address of the 
        device that originally sent the datagram that led to the Redirect being created.

    Neighbor Solicitation
        These ICMPv6 message is part of :term:`NDP`.

        Nodes send Neighbor Solicitations to request the link-layer address
        of a target node while also providing their own link-layer address to
        the target.  Neighbor Solicitations are multicast when the node needs
        to resolve an address and unicast when the node seeks to verify the
        reachability of a neighbor.

        ::

             0                   1                   2                   3
             0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
            +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
            |     Type      |     Code      |          Checksum             |
            +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
            |                           Reserved                            |
            +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
            |                                                               |
            +                                                               +
            |                                                               |
            +                       Target Address                          +
            |                                                               |
            +                                                               +
            |                                                               |
            +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
            |   Options ...
            +-+-+-+-+-+-+-+-+-+-+-+-

            IP Fields:

            Source Address
                            Either an address assigned to the interface from
                            which this message is sent or (if Duplicate Address
                            Detection is in progress [ADDRCONF]) the
                            unspecified address.
            Destination Address
                            Either the solicited-node multicast address
                            corresponding to the target address, or the target
                            address.
            Hop Limit      255

            ICMP Fields:

                Type           135

                Code           0

            Checksum       The ICMP checksum.  See [ICMPv6].

            Reserved       This field is unused.  It MUST be initialized to
                            zero by the sender and MUST be ignored by the
                            receiver.

            Target Address The IP address of the target of the solicitation.
                            It MUST NOT be a multicast address.

    Neighbor Advertisement
        These ICMPv6 message is part of :term:`NDP`.

        A node sends Neighbor Advertisements in response to Neighbor
        Solicitations and sends unsolicited Neighbor Advertisements in order
        to (unreliably) propagate new information quickly.

        ::

             0                   1                   2                   3
             0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
            +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
            |     Type      |     Code      |          Checksum             |
            +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
            |R|S|O|                     Reserved                            |
            +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
            |                                                               |
            +                                                               +
            |                                                               |
            +                       Target Address                          +
            |                                                               |
            +                                                               +
            |                                                               |
            +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
            |   Options ...
            +-+-+-+-+-+-+-+-+-+-+-+-

            IP Fields:

                Source Address
                                An address assigned to the interface from which the
                                advertisement is sent.
                Destination Address
                                For solicited advertisements, the Source Address of
                                an invoking Neighbor Solicitation or, if the
                                solicitation's Source Address is the unspecified
                                address, the all-nodes multicast address.

                                For unsolicited advertisements typically the all-
                                nodes multicast address.

                    Hop Limit      255

                ICMP Fields:

                    Type           136

                    Code           0

                    Checksum       The ICMP checksum.  See [ICMPv6].

                    R              Router flag.  When set, the R-bit indicates that
                                    the sender is a router.  The R-bit is used by
                                    Neighbor Unreachability Detection to detect a
                                    router that changes to a host.

                    S              Solicited flag.  When set, the S-bit indicates that
                                    the advertisement was sent in response to a
                                    Neighbor Solicitation from the Destination address.
                                    The S-bit is used as a reachability confirmation
                                    for Neighbor Unreachability Detection.  It MUST NOT
                                    be set in multicast advertisements or in
                                    unsolicited unicast advertisements.

                    O              Override flag.  When set, the O-bit indicates that
                                    the advertisement should override an existing cache
                                    entry and update the cached link-layer address.
                                    When it is not set the advertisement will not
                                    update a cached link-layer address though it will
                                    update an existing Neighbor Cache entry for which
                                    no link-layer address is known.  It SHOULD NOT be
                                    set in solicited advertisements for anycast
                                    addresses and in solicited proxy advertisements.
                                    It SHOULD be set in other solicited advertisements
                                    and in unsolicited advertisements.

                    Reserved       29-bit unused field.  It MUST be initialized to
                                    zero by the sender and MUST be ignored by the
                                    receiver.

                    Target Address
                                    For solicited advertisements, the Target Address
                                    field in the Neighbor Solicitation message that
                                    prompted this advertisement.  For an unsolicited
                                    advertisement, the address whose link-layer address
                                    has changed.  The Target Address MUST NOT be a
                                    multicast address.


    Router Solicitation
    Router Advertisement
        These ICMPv6 messages are part of :term:`NDP`.

        The ICMP router discovery messages are called "Router Advertisements" 
        and "Router Solicitations". Each router periodically multicasts a 
        Router Advertisement from each of its multicast interfaces, 
        announcing the IP address(es) of that interface. Hosts discover the 
        addresses of their neighboring routers simply by listening for 
        advertisements. When a host attached to a multicast link starts up, 
        it may multicast a Router Solicitation to ask for immediate advertisements, 
        rather than waiting for the next periodic ones to arrive; 
        if (and only if) no advertisements are forthcoming, the host may retransmit 
        the solicitation a small number of times, but then must desist from 
        sending any more solicitations. Any routers that subsequently start up, 
        or that were not discovered because of packet loss or temporary link 
        partitioning, are eventually discovered by reception of their periodic 
        (unsolicited) advertisements.(Links that suffer high packet loss rates 
        or frequent partitioning are accommodated by increasing the rate of 
        advertisements, rather than increasing the number of solicitations that 
        hosts are permitted to send.)

        ::

            ICMP Router Solicitation Message

                0                   1                   2                   3
                0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
                +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
                |     Type      |     Code      |           Checksum            |
                +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
                |                           Reserved                            |
                +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+


            IP Fields:

                Source Address        An IP address belonging to the interface
                                    from which this message is sent, or 0.

                Destination Address   The configured SolicitationAddress.

                Time-to-Live          1 if the Destination Address is an IP
                                    multicast address; at least 1 otherwise.

            ICMP Fields:

                Type                  10

                Code                  0

                Checksum              The  16-bit one's complement of the one's
                                    complement sum of the ICMP message, start-
                                    ing with the ICMP Type.  For computing the
                                    checksum, the Checksum field is set to 0.

                Reserved              Sent as 0; ignored on reception.


            ICMP Router Advertisement Message

                0                   1                   2                   3
                0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
                +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
                |     Type      |     Code      |           Checksum            |
                +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
                |   Num Addrs   |Addr Entry Size|           Lifetime            |
                +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
                |                       Router Address[1]                       |
                +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
                |                      Preference Level[1]                      |
                +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
                |                       Router Address[2]                       |
                +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
                |                      Preference Level[2]                      |
                +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
                |                               .                               |
                |                               .                               |
                |                               .                               |


            IP Fields:

                Source Address        An IP address belonging to the interface
                                    from which this message is sent.

                Destination Address   The configured AdvertisementAddress or the
                                    IP address of a neighboring host.

                Time-to-Live          1 if the Destination Address is an IP
                                    multicast address; at least 1 otherwise.


            ICMP Fields:

                Type                  9

                Code                  0

                Checksum              The  16-bit one's complement of the one's
                                    complement sum of the ICMP message, start-
                                    ing with the ICMP Type.  For computing the
                                    checksum, the Checksum field is set to 0.

                Num Addrs             The number of router addresses advertised
                                    in this message.

                Addr Entry Size       The number of 32-bit words of information
                                    per each router address (2, in the version
                                    of the protocol described here).

                Lifetime              The maximum number of seconds that the
                                    router addresses may be considered valid.

                Router Address[i],    The sending router's IP address(es) on the
                i = 1..Num Addrs     interface from which this message is sent.

                Preference Level[i],  The preferability of each Router Address[i]
                i = 1..Num Addrs      as a default router address, relative to
                                    other router addresses on the same subnet.
                                    A signed, twos-complement value; higher
                                    values mean more preferable.

    `SEnD <http://en.wikipedia.org/wiki/Secure_Neighbor_Discovery_Protocol>`_
        The Secure Neighbor Discovery (SEND) protocol is a security extension of
        the Neighbor Discovery Protocol (NDP) in IPv6 defined in :rfc:`3971`.

        .. note::

              There exists opensource implenetation of SEnD avalible at 
              `http://code.google.com/p/ipv6-send-cga/ <http://code.google.com/p/ipv6-send-cga/>`_.

    `CGA <http://en.wikipedia.org/wiki/Cryptographically_Generated_Address>`_
        A Cryptographically Generated Address is formed by replacing the
        least-significant 64 bits of the 128-bit IPv6 address with the cryptographic
        hash of the public key of the address owner. The messages are signed 
        with the corresponding private key. Only if the source address and the 
        public key are known can the verifier authenticate the message from that
        corresponding sender. This method requires no public-key infrastructure.
        Valid CGAs may be generated by any sender, including a potential attacker, 
        but they cannot use any existing CGAs. They are defined in :rfc:`3972`.

        .. note::
            
            There exists opensource implementation of CGA implemented in userspace
            using :term:`scapy` and kernel hook avalible at
            `http://amnesiak.org/NDprotector/ <http://amnesiak.org/NDprotector/>`_.

    ND
    `NDP <http://en.wikipedia.org/wiki/Neighbor_Discovery_Protocol>`_
        The Neighbor Discovery Protocol (NDP) is a protocol in the
        Internet Protocol Suite used with Internet Protocol Version 6 (IPv6). 
        It operates in the Link Layer of the Internet model :rfc:`1122` and is 
        responsible for address autoconfiguration of nodes, discovery of other 
        nodes on the link, determining the Link Layer addresses of other nodes, 
        duplicate address detection, finding available routers and 
        Domain Name System (DNS) servers, address prefix discovery, and maintaining 
        reachability information about the paths to other active neighbor nodes 
        (:rfc:`4861`).

    `SLAAC <http://en.wikipedia.org/wiki/IPv6#Stateless_address_autoconfiguration_.28SLAAC.29>`_
        IPv6 hosts can configure themselves automatically when connected to a routed
        IPv6 network using the Neighbor Discovery Protocol via 
        Internet Control Message Protocol version 6 (ICMPv6) router discovery messages. 
        When first connected to a network, a host sends a link-local router 
        solicitation multicast request for its configuration parameters; 
        if configured suitably, routers respond to such a request with a router 
        advertisement packet that contains network-layer configuration parameters.

    `IPSec <http://en.wikipedia.org/wiki/IPsec>`_
        Internet Protocol Security (IPsec) is a protocol suite for securing
        Internet Protocol (IP) communications by authenticating and encrypting 
        each IP packet of a communication session. IPsec also includes protocols
        for establishing mutual authentication between agents at the beginning 
        of the session and negotiation of cryptographic keys to be used during 
        the session.

    `hop-by-hop <http://en.wikipedia.org/wiki/IPv6_packet#Hop-by-hop_options_and_destination_options>`_
        The Hop-by-Hop option header is a type of IPv6 extension header that
        has been defined in the IPv6 protocol specification.  The contents of
        this header need to be processed by every node along the path of an
        IPv6 datagram.

    `THC-ipv6 <http://www.thc.org/thc-ipv6/>`_
        A complete tool set to attack the inherent protocol weaknesses of IPV6
        and ICMP6, and includes an easy to use packet factory library. 
        The **THC IPV6 ATTACK TOOLKIT** comes already with lots of effective attacking
        tools:

            - parasite6: icmp neighbor solitication/advertisement spoofer, puts you
              as man-in-the-middle, same as ARP mitm (and parasite)
            - alive6: an effective alive scanng, which will detect all systems
              listening to this address
            - dnsdict6: parallized dns ipv6 dictionary bruteforcer
            - fake_router6: announce yourself as a router on the network, with the
              highest priority
            - redir6: redirect traffic to you intelligently (man-in-the-middle) with
              a clever icmp6 redirect spoofer
            - toobig6: mtu decreaser with the same intelligence as redir6
            - detect-new-ip6: detect new ip6 devices which join the network, you can
              run a script to automatically scan these systems etc.
            - dos-new-ip6: detect new ip6 devices and tell them that their chosen IP
              collides on the network (DOS).
            - trace6: very fast traceroute6 with supports ICMP6 echo request and TCP-SYN
            - flood_router6: flood a target with random router advertisements
            - flood_advertise6: flood a target with random neighbor advertisements
            - fuzz_ip6: fuzzer for ipv6
            - implementation6: performs various implementation checks on ipv6
            - implementation6d: listen daemon for implementation6 to check behind a FW
            - fake_mld6: announce yourself in a multicast group of your choice on the net
            - fake_mld26: same but for MLDv2
            - fake_mldrouter6: fake MLD router messages
            - fake_mipv6: steal a mobile IP to yours if IPSEC is not needed for authentication
            - fake_advertiser6: announce yourself on the network
            - smurf6: local smurfer
            - rsmurf6: remote smurfer, known to work only against linux at the moment
            - exploit6: known ipv6 vulnerabilities to test against a target
            - denial6: a collection of denial-of-service tests againsts a target
            - thcping6: sends a hand crafted ping6 packet
            - sendpees6: a tool by willdamn@gmail.com, which generates a neighbor
              solicitation requests with a lot of CGAs (crypto stuff ;-) to keep the
              CPU busy. nice.
    
    scapy
        `Scapy <http://www.secdev.org/projects/scapy/>`_ is a powerful interactive packet manipulation program.

    vagrant
    Vagrant
        `Vagrant <http://www.vagrantup.com/>`_ Vagrant uses Oracle’s VirtualBox
        to build configurable, lightweight, and portable virtual machines dynamically.
       
    puppet
    Puppet
        `Puppet <http://puppetlabs.com/>`_ Puppet is IT automation software that
        helps system administrators manage infrastructure throughout its lifecycle,
        from provisioning and configuration to patch management and compliance. 
