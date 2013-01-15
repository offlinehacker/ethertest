***********
Development
***********

This section is about basics for understanding network development environment.

It's all about virtual environments
-----------------------------------

I know some people who just setup network and it works and as i said i am not
that kind of person. I like to test and debug what's i'm doing. I know many network
incidents where networks have been hacked because of inproper network configurations.
I don't want to be hacked, i want to know that i am at least slightly secure.

Because of simplicity i decide to use virtual environemnts for testing.
I decided to take virtualbox, because it allows me to 
put different enterprise network elements into it, like mikrotik, cisco,... and
other enterpise solutions. At the same time it allows me to setup virtual network.
But if you are doing only linux then openvz, lxc, kvm, virtual box or any virtualization
that helps you build virtual network should suffice.

.. note::

    You can use any operating system, but i recomend usage of linux, because it's so
    much better for development and i will support only linux.

Deployment
----------

It's important to have a way how you will deploy your systems, and it-s
configuration. This way you will easy migrate from development to production by
just pushing your config to all your network elements. I decided to use puppet,
for my linux boxes, but mostly all enterpise network elements have their
deployment systems integrated.

Testing
-------

I decide to split network testing in five phases:

* **Network conectivety testing**::
  
    This kind of testing is used for verification of conectivety between 
    network segments.

* **Network correctness tesing**::

    This kind of testing is used for testing correctness of network filters 
    (firewalls) of how they separate different network segments.

* **Network security testing**::
  
    This kind of testing is used for testing of network firewalls and prevention 
    of common attacks on different network segments.

* **Network intrusion testing**::
  
    This kind of testing is used for testing of intrusion detection systems and 
    common attacks on any network services.
  
* **Host intrusion testing**::
  
    This kind of testing is used for testing of host intrusion detection systems 
    and common attacks on.

* **Human stupidty testing**::

    This kind of testing, is testing for human stupidity, like weak passwords, 
    bad written hosted applications with bugs like sql-injection and xss and similar.
    It might be insulting to someone to call it human stupidity, but that what 
    itreally is. Most of the times it might be also called human lazines.

    .. note::

        There is nothing more serious then human stupidity, if you are going 
        to have username and password `test`:`test`, hacerkers will easily 
        compromise your whole system. Some things can still be tested by using
        intrusive approaches, usually with automated security testing applications 
        and sometimes with pen-testing by hand.

.. note::

    It must be evaluated what should be tested and what does not need to be tested.
    Testing first three phases should be trivial enough. Testing last three phases is
    more complicated and only common things may be tested.

.. warning::

    Even when you will think you are secure, belive me, you are not! Some very good
    hackers will still find way in, but at least you will be able to migrate attack
    the best way possible and much less damage will be done, and at the same time you
    will know what have hackers done to you or your clients and how can you fix that.
