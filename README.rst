EtherTest
=========

Testbed for ethernet networks

Documentation is avalible at `http://offlinehacker.x-truder.net/ethertest/ <http://offlinehacker.x-truder.net/ethertest/>`_

We are trying to make this project as good as our knowledge about networking is,
but we are still learning and we know you can make it even better!

**Any contributions in form of knowledge, comments, new ideas, bug reports and more
that would make ethertest better are very welcome.**

Development
-----------

System requierments:

* Any moderen linux distribution supported by vagrant and virtualbox
* x86_64 or any other arhitecture supported by virtualbox,
  hardware virtualization is not a requierment.
* 2Gigs or more memory

    .. note::

        VirtualBox can run inside os-based virtualization like openvz or lxc,
        that's also why we use bridge networking inside virtual boxe-s(host-only does not work).

Requierments:

* Python 2.7
* `VirtualBox <https://www.virtualbox.org/wiki/Downloads>`_ 4.2.4 or newer
* `Vagrant <http://downloads.vagrantup.com>`_ 1.0.5 or newer
* System packages: `iptables`, `tunctl`, `dnsmasq`

Development::

    $ git clone git@github.com:offlinehacker/ethertest.git
    $ git submodule update
    $ cd ethertest
    $ python setup.py develop
    $ vagrant gem install vagrant-hiera
    $ vagrant up [name]

Update

    ::

        $ git pull origin master
        $ git submodule update --init
        $ vagrant destroy (only if you are having problems)
        $ vagrant up [name]

    .. note::
        
        You don't need to destroy, `vagrant provision` should do the task 
        in most cases. If you are having problems first try to halt (vagrant halt -f name)
        or reload you virtual machines.


Ubuntu 12.04/12.10 instructions

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

        To activate and deactivate python virtualenv use `source bin/activate` and `deactivate` commands.

        If you are having problems with installing vagrant try to install x64 version. On the other hand
        if you are having problems with numpy try `pip install numpy`, and then again `python setup.py develop`

Bringing up virtual box-es
--------------------------

    .. note::

        Configurations for virtual box-es are located inside `Vagrantfile`.

First you need to start your network, dhcp server and nat.
Please make sure `tunctl`, `dnsmaq` and `iptables` commands are installed

    ::

        $ fab netstart
        $ fab dhcp
        $ fab natstart

    .. note::

        Configuration for network subnets(interfaces) are located inside `fabfile.py`.
        `VirtualBox` will bridge with virtual intefaces as specified inside `Vagrantfile`.

* To bring-up virtual box use
  
    ::

        $ vagrant up [name]

* To shut down virtualbox use

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

To ssh to virtualbox use

    ::

        $ vagrant ssh [name]

Testing
-------

    .. note::

        Tests are located inside `./ethertest/tests/`.

We use nose for running tests

    ::

        $ python setup.py test

    .. note::
        
        For testing security of ipv6 you need thc-ipv6 tools installed.

Building docs
-------------

Documentation is located in `docs/` folder. To build it do

    ::

        $ sphinx-build -b html docs/ build/

    .. note::

        Documentation is written in `reStructuredText <http://docutils.sourceforge.net/rst.html>`_
        markup language and is using `sphinx <http://sphinx-doc.org/>`_ speciffics and builders.
