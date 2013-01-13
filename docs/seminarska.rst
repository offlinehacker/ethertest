=========
Ethertest
=========

---------------------------------------------------------
A custom virtual network environment for security testing
---------------------------------------------------------


Introduction
============

The world today is a fast paced conundrum where people tend to do too many things
at the same time using all free time for work. It's a world where downtime for
servers and networks, on which practically everything nowadays bases, is not
wanted and can sometimes have a pretty negative impact on everything that runs on it.

Networks tend to be complex and many times insecure, running all kinds of different
protocols like: ethernet, arp, ipv4, ipv6 and other higher level application protocols.
This complexity and intertwining of protocols has to be kept secure, which means
it has to block intruders and log the activity on the system.

The complex networks and systems are pretty expensive. That means we have to find
a different cheaper approach for testing the network stability, if it's even
working as planned and the many times forgotten part: THE SECURITY!
Our objective is understanding the existing threats related to IPv6 and testing
different security measures against potential attacks.

Our aproach taken is as follows: For the simplicity of it we use a virtual
environment in this case Oracle's VirtualBox on linux based oparating systems.
It allows us to run, test and study different tipes of enterprise network systems
like mikrotik, cisco, etc. What's more it allows us to setup a virtual network,
perfect for testing purposes.

What was created was a self deployable system, that creates a virtual environment
with different network adapters and a router running the firewall.


The project will be devided in three sections:
-The testing environment
    -Why we took our approach
    -How to setup the system
    -Our system configurations

-About IPv6
    -IPv6 features and security problem
    -Some possible attacks

-Testing the security
    -The testing phases


