===============
Network testing
===============

Testing networks is very important, not only it will it shorten the time used for
configuring your network, but it will also allow you to prove that your network
is secure.

We decided to make network testing independant from network implmentations,
because this would allow us to test different kinds of netoworks with different
equipment in different netowork topologies.

Network testing could be roughly split in these five phases:

* **Network conectivety testing**
  
    This kind of testing is used for verification of connectivity between 
    network segments.

* **Network correctness tesing**

    This kind of testing is used for testing the correctness of network filters 
    (firewalls) and how they separate different network segments.

* **Network security testing**
  
    This kind of testing is used for testing the network firewalls and prevention 
    of common attacks on different network segments.

* **Network intrusion testing**
  
    This kind of testing is used for testing the intrusion detection systems and 
    common attacks on any network services.
  
* **Host intrusion testing**
  
    This kind of testing is used for testing host intrusion detection systems 
    and common attacks on them.

* **Human stupidty testing**

    This tests actually test human stupidity, like weak passwords, badly written
    hosted applications with bugs like sql-injection and xss and similar.
    It might be insulting to someone to call it human stupidity, but that is
    actually what it really is. Most of the time it might be also called human
    lazines.

    .. note::

        There is nothing more serious then human stupidity, if you are going 
        to have username and password `test`:`test`, hacerkers will easily 
        compromise your whole system. Some things can still be tested by using
        intrusive approaches, usually with automated security testing applications 
        and sometimes with pen-testing by hand.

.. note::

    It must be evaluated what should be tested and what does not need to be tested.
    Testing the first three phases should be trivial enough. Testing the last three
    phases is way more complicated and only some of the common things may be tested.
