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

That's why i decide to use virtual environemnts for testing. It doesn't matter what
virtualization are you using. I decided to take virtualbox, because it allows me to 
put different enterprise network elements into it, like mikrotik, cisco,... and
other enterpise solutions. At the same time it allows me to setup virtual network.
But if you are doing only linux openvz, lxc, kvm, virtual box or any virtualization
that helps you build virtual network should suffice.

.. note::

    You can use any operating system, but i recomend usage of linux, because it's so
    much better for development and i will support only linux.

Deployment
----------

It's important to have a way how you will deploy your systems, and it's
configuration. This way you will easy migrate from development to production by
just pushing your config to all your network elements. I decided to use puppet,
for my linux boxes, but mostly all enterpise network elements have their
deployment systems integrated.

Testing
-------

I decide to split testing in five phases:

* Network conectivety testing
  This kind of testing is used for verification of conectivety betwene network segments.

* Network correctness tesing
  This kind of testing is used for testing correctness of network filters(firewalls) of 
  how they separate different network segments.

* Network security testing
  This kind of testing is used for testing of network firewalls and prevention of common
  attacks on different network segments.

* Network intrusion testing
  This kind of testing is used for testing of intrusin detection systems and common attacks
  on any network services.
  
* Network intrusion testing
  This kind of testing is used for testing of intrusin detection systems and common attacks
  on any nnetwork services.
