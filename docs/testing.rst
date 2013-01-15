===============
Network testing
===============

Testing networks is very important, not only it will short your time while
configuring your network, it will also allow you to prove that your network
is secure.

We decided to make network testing independant from network implmentations,
because this would allow us to test different kinds of netowork with different
kinds of equipment in different netowork topologies.

Network testing could be roughly split in these five phases:

* **Network conectivety testing**
  
    This kind of testing is used for verification of conectivety between 
    network segments.

* **Network correctness tesing**

    This kind of testing is used for testing correctness of network filters 
    (firewalls) of how they separate different network segments.

* **Network security testing**
  
    This kind of testing is used for testing of network firewalls and prevention 
    of common attacks on different network segments.

* **Network intrusion testing**
  
    This kind of testing is used for testing of intrusion detection systems and 
    common attacks on any network services.
  
* **Host intrusion testing**
  
    This kind of testing is used for testing of host intrusion detection systems 
    and common attacks on.

* **Human stupidty testing**

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
