===================
Testing enivronment
===================

-------------------------
Why we took this approach
-------------------------

There are lots of different alternatives for testing network security, there are
plenty of commercial router emulators. But every one of them misses something
and are not entirely custumizable. That's why we chose Vagrant to setup our
virtual environment (using Oracle's virtualbox virtualization software, where we
can run practically what we wish) and scapy to manage and create test packets to
send through our networks.

------------------
Project components
------------------

The following is used to run the project::

-Developing: Python 2.7
-Running the virtual environment: Virtualbox 4.2.4 or newer
-Deploying the test system: Vagrant 1.0.5 or newer
-Testing purposes: scapy
-System packages needed: iptables, tunctl, dnsmasq


:term:`Vagrant`

Vagrant uses Oracle’s VirtualBox to build configurable, lightweight, and portable
virtual machines dynamically. After that it uses Puppet to provision them. That
means it can deploy the entire testing system with the configurations made by us.
From running a router with preconfigured routing to simulating a private machine
getting an IP with dhcp from the router.

:term:`Puppet`

It gives us the ability to configure the virtual machines once they are set up.
That means it can install applications, manage and configure the system so they
appear and behave as we wish. For example it can set up the machines with different
network adapterswith different configurations, like using DHCP to get an IP from
the router or setting static IPs.

:term:`scapy`

The author says it all: "Scapy is a powerful interactive packet manipulation program.
It is able to forge or decode packets of a wide number of protocols, send them
on the wire, capture them, match requests and replies, and much more. It can easily
handle most classical tasks like scanning, tracerouting, probing, unit tests,
attacks or network discovery (it can replace hping, 85% of nmap, arpspoof, arp-sk,
arping, tcpdump, tethereal, p0f, etc.). It also performs very well at a lot of
other specific tasks that most other tools can't handle, like sending invalid
frames, injecting your own 802.11 frames, combining technics (VLAN hopping+ARP
cache poisoning, VOIP decoding on WEP encrypted channel, ...), etc."

-------------------------
How to setup the system
-------------------------

This  is  a step by step how-to on setting up the testing environment. The following
directions are based for machines running Ubuntu 12.04 or 12.10.

____________________
System requierments:
____________________

* Any moderen linux distribution supported by vagrant and virtualbox
* x86_64 or any other arhitecture supported by virtualbox,
  hardware virtualization is not a requierment.
* 2GB or more memory

.. note::

    VirtualBox can run inside os-based virtualization like openvz or lxc,
    that's also why we use bridged networking inside virtual boxes (host-only does not work).

_____________
Requierments:
_____________

* Python 2.7
* `VirtualBox <https://www.virtualbox.org/wiki/Downloads>`_
* `Vagrant <http://downloads.vagrantup.com>`_
* System packages: `iptables`, `tunctl`, `dnsmasq`

-----------
Development
-----------

::

    $ git clone git@github.com:offlinehacker/ethertest.git
    $ git submodule update
    $ cd ethertest
    $ python setup.py develop
    $ vagrant gem install vagrant-hiera
    $ vagrant up [name]

**Updating**

::

    $ git pull origin master
    $ git submodule update --init
    $ vagrant destroy [name](only if you are having problems)
    $ vagrant up [name]

.. note::
        
    You don't need to destroy::
        
        $ vagrant provision

    should do the task in most cases. If you are having problems first try
    to halt or reload you virtual machines::

        $ vagrant halt -f [name]
        $ vagrant reload [name]

_______________________________
Ubuntu 12.04/12.10 instructions
_______________________________

::

    $ wget http://download.virtualbox.org/virtualbox/4.2.4/virtualbox-4.2_4.2.4-81684~Ubuntu~precise_amd64.deb
    $ sudo dpkg -i virtualbox-4.2_4.2.4-81684~Ubuntu~precise_amd64.deb
    $ wget http://files.vagrantup.com/packages/be0bc66efc0c5919e92d8b79e973d9911f2a511f/vagrant_1.0.5_i686.deb
    $ sudo dpkg -i vagrant_1.0.5_i686.deb
    $ sudo apt-get install python python-dev python-virtualenv dnsmasq iptables uml-utilities
    $ git clone git@github.com:offlinehacker/ethertest.git
    $ virtualenv --no-site-packages --python=python2.7 ethertest
    $ cd ethertest
    $ source bin/activate
    $ python setup.py develop

.. note::

    To activate and deactivate python virtual environment use
    "$ source bin/activate" and "deactivate" commands.

.. note::

    If you are having problems with installing vagrant try installing the x64 version.
    ::

        $ wget http://files.vagrantup.com/packages/be0bc66efc0c5919e92d8b79e973d9911f2a511f/vagrant_1.0.5_x86_64.deb
        $ sudo dpkg -i vagrant_1.0.5_x86_64.deb

.. note::

    If you're having problems developing setup.py try installing numpy before running it::

        $ pip install numpy
    

--------------------------
Bringing up virtual box-es
--------------------------

.. note::

    Configurations for the virtual boxes are located inside `Vagrantfile`.

* Please make sure `tunctl`, `dnsmasq` and `iptables` commands are installed.

  .. note::

    There must be no dnsmasq process running else vagrant won't start up.
    Check it with::

        $ ps -e | grep dnsmasq

    If the output shows dnsmasq running, kill it with::

        $ sudo killall dnsmasq

* First of all we need to start the network, dhcp server and nat. The following
  commands also create new network interfaces::

    $ fab netstart
    $ fab dhcp
    $ fab natstart:[interface with internet connectivity]

  .. note::

    Configuration for network subnets(interfaces) are located inside `fabfile.py`.
    `VirtualBox` will bridge with virtual intefaces as specified inside `Vagrantfile`.

* To bring-up a virtual box use::

        $ vagrant up [name]

  .. note::

    In the included configuration the virtualboxes are Router, Priv(a private network),
    Prod(a development/production network)

  .. note::

    If getting errors about vagrant-hiera missing, please install it before running vagrant:

    ::

    $ vagrant gem install vagrant-hiera

* To shut down a virtual box use::

    $ vagrant halt [name]

* If the box refuses to terminate try this instead::

    $ vagrant halt [name] -f

.. note::

    You can also run virtualbox to debug and control your running virtualboxes.

.. warning::

    If `vagrant` command is not avalible you must setup your search `PATH` variable.
    You can set it by doing the following::

        $ export PATH=$PATH:/opt/vagrant/bin

    To make it persistent add it at the bottom of your `~/.profile` file.

* To ssh to a virtualbox use::

    $ vagrant ssh [name]
