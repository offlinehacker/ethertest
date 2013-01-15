===========================
Network deployment in linux
===========================

Here we will present our secure deployment of simulted corporate network
using linux as a core router.

Standard virtualisation environment used in this project, :term:`vagrant` was 
used and :term:`puppet` was used for deployment of everything, but you can
read more about it this :doc:`environment`.

------------------
Deployment modules
------------------

For effective deployment configuration we used :term:`puppet` modules, some of
which were custom made, to fit our needs. All module are located under
`puppet/modules/`.

* iptables module (`https://github.com/offlinehacker/puppet-iptables <https://github.com/offlinehacker/puppet-iptables>`_)

  This is our custom made iptables module for deployment of linux firewall using 
  :term:`augeas`. This allows us to have iptables config that is not overwritten
  by :term:`puppet`, but only gets updated, so if somebody needs to add firewall
  rule by hand it's still possible.

  .. note::

    We tought about using fwbuilder tool, but decided that we want to learn
    iptables better, and at the same time wanted to have integration with our
    rest configuration, so that's one of the reason why we didn't use that tool.

  .. warning::

    When official puppet firewall module will add support for cisco and maybe
    for mikrotik, we will migrate and use that module, because this will allow
    us to have same firewall configuration for different devices.

* ifconfig module

  This module for netowork interface configuration has same philosophy as module above, 
  but has not been yet made in standalone module. It's at the same time very 
  easy to migrate to another module, so it's not that important. 
  We used it, because usage of :term:`augeas` seemd super cool.

* dnsmasq module

  DHCP module, used for dynamic assignments of ipv4 addresses in private netoworks.

* radvd module

  :term:`NDP` server, used fot dynamic assignments of ipv6 addresses in private
  netowrks and :term:`Router Advertisement`.

* IPSec module

  :term:`IPSec` module for providing end to end secure communication in production
  environments.
