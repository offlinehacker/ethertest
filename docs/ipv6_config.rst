==========================
IPv6 killed the IPv4 star!
==========================

--------------------
Something about IPv6
--------------------

- IPv6 development started in the early 1990 with few focus on security;
- Some IPv4 well known security breaches like arp poisoning, address spoofing, etc. have their correspondent on IPv6;
- Some new IPv6 features create new vulnerabilities as well as transition process;
- There are already many IPv6 hacking tools available for anyone on the Internet;
- IPv6 deployment is still slow and vulnerabilities are not yet widely shared, but this scenario is about to change.


It should be very easy to turn on IPv6 support and enable it to work, that
was the core idea of IPv6. You don't need dhcp anymore, everyone gets IPv6
address for free and basically everything gets configured automatically.
That's for client, but what should we do for router to make it work?

Well it turns out if you do that, you will be mostly very insecure. Not
only that some old attacks affect you, but there are also new attacks that
affect ipv6 users. To make ipv6 secure you must configure it corretly and
test configurations.


-----------------------------------------------    
New IPv6 features and related security problems
-----------------------------------------------

**1.Larger Adress Space:**

    end to end architecture allowing full tracking and some applications 
    that were impossible with IPv4 and NAT, which changes the way network
    scanning and reconnaisance works. New BOGON threats.
    
    "Bogon filtering is the practice of filtering bogons, which are bogus
    IP addresses. Bogon is also an informal name for an IP packet on the public
    Internet that claims to be from an area of the IP address space reserved,
    but not yet allocated or delegated by the Internet Assigned Numbers Authority
    (IANA) or a delegated Regional Internet Registry (RIR). The areas of
    unallocated address space are called the bogon space."

**2.Enhanced Header:**

    simpler and more efficient header with 40 fixed bytes and adds the
    possibility of extension headers which leads to vulnerabilities related
    to them, opening new venues for attacks.

**3. Improved ICMP (ICMPv6) and Multicast management:**

    increased efficiency, allows auto-configuration, neighborhood discovery
    and multicast group management. No authentication can lead to different
    older attacks and new ones. Multicast capabilities can be exploited to
    gather network informations (reconnaissance).

**4. Auto configuration:**

    makes end user configuration easier. A very useful feature for a "tipical"
    computer user, who wants automatization. That also makes end users exposed
    to certain malicious attacks, specially at public locations.

**5. Fragmentation only at source:**

    data transmission are more efficient and have less overhead on intermediary
    routers. That makes ICMPv6 control more difficult, which leads to new
    attacks based on forged ICMPv6 messages.

**6. Mobility support:**

    mobility support integrated in the protocol allows nomadic and roaming
    applications. That means we get new connection interceptions with new
    man-in-the-middle and DOS (denial of service) attacks.

**7. IPv4 to IPv6 transition**

    since IPv4 is said to be used for at least 20 more years, transitioning
    from IPv4 to IPv6 means that most systems will have to run both and also
    use several tunneling techniques, meaning network adiminstrators have to
    put more effort in configuring the network which means more chance of
    having security holes, leading to possible new exploits and attacks.
