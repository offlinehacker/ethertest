************
installation
************

System requierments:
--------------------

* Any moderen linux distribution supported by vagrant and virtualbox
* x86_64 or any other arhitecture supported by virtualbox,
  hardware virtualization is not a requierment.
* 2Gigs or more memory

.. note::

    VirtualBox can run inside os-based virtualization like openvz or lxc,
    that's also why we use bridge networking inside virtual boxe-s (host-only does not work).

Requierments:
-------------

* Python 2.7
* `VirtualBox <https://www.virtualbox.org/wiki/Downloads>`_
* `Vagrant <http://downloads.vagrantup.com>`_
* System packages: `iptables`, `tunctl`, `dnsmasq`

Development
-------------

::

    $ git clone git@github.com:offlinehacker/ethertest.git
    $ cd ethertest
    $ python setup.py develop

Update::

    $ git pull origin master

Ubuntu 12.04 instructions::

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

    To activate and deactivate python virtualenv use `source bin/activate` and `deactivate` commands.

Bringing up virtual box-es
--------------------------

.. note::

    Configurations for virtual box-es are located inside `Vagrantfile`.

* First you need to start your network, dhcp server and nat.
  Please make sure `tunctl`, `dnsmaq` and `iptables` commands are installed

  ::

    $ fab netstart
    $ fab dhcp
    $ fab natstart

  .. note::

    Configuration for network subnets(interfaces) are located inside `fabfile.py`.
    `VirtualBox` will bridge with virtual intefaces as specified inside `Vagrantfile`.

* To bring-up virtual box use::

        $ vagrant up [name]

* To shut down virtual box use
  
  ::

    $ vagrant halt [name]

  .. note::

    You can also start virtualbox and control and debug your running virtual box-es
    form there.

  .. warning::

    If `vagrant` command is not avalible you must setup your search `PATH` variable.
    You can set it by doing something like this::

        $ export PATH=$PATH:/opt/vagrant/bin

    To make it persistent edit your `~/.profile` file.

* To ssh to virtualbox use::

    $ vagrant ssh [name]

Testing
-------

.. note::

    Tests are located inside `./ethertest/tests/`.

We use nose for running tests::

    $ python setup.py test
