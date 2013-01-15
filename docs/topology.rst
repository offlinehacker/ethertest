----------------
Network topology
----------------

Network topology is the connection, arrangement or structure of a network.
There are two categories of topology, Physical topology which refers to
the placement of the physical network components (be it routers, cables, etc.)
and Logical topology that shows how data flows through a network.

We divide them in 4 basic topologies which form all the possible network forms.
    - :term:`Bus topology`
    - :term:`Star topology`
    - :term:`Ring topology`
    - :term:`Mesh topology`

.. glossary::

    Bus topology

        This topology consists of network elements connected to a single, shared cable.

        .. image:: _static/NetworkTopology-Bus.png

        Pros:
            - cheap, economic cabling
            - the medium is cheap and easy to handle
            - easy to setup 
            - easy to upgrade

        Cons:
            - slows down when the network traffic rises
            - errors are hard to notice
            - interruption of the medium means network goes down

    Star topology

        Each nework host is connected directly with a central device called a hub or switch.

        .. image:: _static/NetworkTopology-Star.png

        Pros:
            - easy connection of new hosts
            - error on a device or cable doesn't mean the netork does down
            - offers the possibility of a centralized control and management

        Cons:
            - if the central device errs, the entire network goes down
            - lots of cabling needed

    Ring topology

        Devices in this topology form a circle. Data travels in one direction and each device
        serves for keeping the signal strong. That means every device has to have a reciever for
        the incoming signal and a transmiter for the outbound signal.

        .. image:: _static/NetworkTopology-Ring.png

        Pros:
            - no device has higher priority, they are equivalent
            - network load doesn't increase with more hosts
            - high connection reliability

        Cons:
            - error on a device or cable means network goes down
            - errors are hard to notice
            - netork upgrade means connection down

    Mesh topology

        This topology connects each device with all the others in the netowrk,

        .. image:: _static/NetworkTopology-FullyConnected.png

        Pros:
            - the system is stable because of the redundant connections

        Cons:
            - expensive

__________________________
Example network topologies
__________________________


.. glossary::

    Standard corporate star type topology
        It consists of a router, a private and a production host. The router acts as a
        central hub, routing all connections from the internet to and from the other
        two hosts.

        .. image:: _static/standardcorp.png
            :width: 100%
