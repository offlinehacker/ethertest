# -*- coding: utf-8 -*-
"""
.. module:: fabfile.py
   :platform: Unix
   :synopsis: Different utils for configuring local testing network
"""

from __future__ import print_function

from jinja2 import Environment
from jinja2.loaders import FileSystemLoader

from fabric.api import task, env, run, sudo, local, cd, settings

from cuisine import *

env.path = "templates"

env.settings = {
    "managment": {
        "name": "manage",
        "ip": "192.168.0.1/24",
        "static": [{"mac":"08:00:27:00:00:01", "ip":"192.168.0.2"},#router
                   {"mac":"08:00:27:00:00:02", "ip":"192.168.0.5"},#loophole
                   {"mac":"08:00:27:00:00:03", "ip":"192.168.0.6"},#extserv
                   {"mac":"08:00:27:00:00:04", "ip":"192.168.0.7"},#production
                   {"mac":"08:00:27:00:00:05", "ip":"192.168.0.8"}],#private

        "dhcp_start": "192.168.0.10",
        "dhcp_stop": "192.168.0.255"
    },
    "subnets": {
        "ext": {
            "ip": "192.168.10.1/24",
            "ipv6": "2001:db8::fffe/80"
        },
        "priv": {
            "ip": "10.1.0.254/16",
            "ipv6": "2001:db8:0:0:1::fffe/80"
        },
        "prod": {
            "ip": "10.2.0.245/16",
            "ipv6": "2001:db8:0:0:2::fffe/80"
        }
    }
}

def template_jinja2(template, params):
    """
    Generates template using jinja2

    :param template: Local path to template
    :type template: str

    :returns: Generated text
    :rtype: str
    """

    env.get("path") or err("env.path not set")

    jenv= Environment(loader=FileSystemLoader(env.path))
    text= jenv.get_template(template).render(**params or {})

    return text

def gen_template(template, out=None):
    if not out:
        out = template
    txt = template_jinja2(template, env.settings)
    f = open(out, 'w')
    f.write(txt)
    f.close()

@task
def mknet(name, ip4="192.168.1.1/24", ip6=None):
    """
    Creates new virtual(tap) network device, requires tunctl command; params: name, ip4, [ip6]

    :param name: Name of network device
    :type name: str
    :param ip4: IPv4 address and netmask (ex: 192.168.1.1/24)
    :type ip4: str
    :param ip6: IPv6 address and netmask
    :type ip6: str
    """

    print("Creating new network device %s with ipv4 %s and ipv6 %s"
          %(name, ip4, ip6))
    with mode_local():
        if not run("ifconfig %s"% name).succeeded:
            sudo("tunctl -g vboxusers -t %s" %name)

        sudo("ifconfig %s %s" %(name,ip4))
        sudo("ifconfig %s up" %name)

        if ip6:
            sudo("ip -6 addr add %s dev %s" %(ip6, name))

    print("Network device created")

@task
def rmnet(name):
    """
    Removes virtual(tap) network device, requires tunctl command; params: name

    :param name: Name of network device
    :type name: str
    """

    print("Removing network device %s" %name)

    with mode_local():
        sudo("ifconfig %s down" %name)
        sudo("tunctl -d %s" %name)

    print("Network device removed")

@task
def dhcp():
    """
    Starts dnsmasq dns server on managment interface, requires dnsmasq server
    """

    with mode_local():
        gen_template("dnsmasq.conf")
        if file_exists("/var/run/dnsmasq.pid"):
            print("dnsmasq is already running, killing it")
            sudo("kill %s" %run("cat /var/run/dnsmasq.pid"))
            sudo("rm /var/run/dnsmasq.pid")

        sudo("dnsmasq -C dnsmasq.conf")

@task
def dhcp_stop():
    """
    Stops dnsmasq dns server
    """

    with mode_local():
        if file_exists("/var/run/dnsmasq.pid"):
            print("dnsmasq is already running, killing it")
            sudo("kill %s" %run("cat /var/run/dnsmasq.pid"))
            sudo("rm /var/run/dnsmasq.pid")

@task
def netstart():
    """
    Creates all network devices specified in `env.settins.subnets`, requires tunctl
    """

    print("Starting network")
    with mode_local():
        mknet(env.settings["managment"]["name"], env.settings["managment"]["ip"])
        for name, subnet in env.settings["subnets"].iteritems():
            mknet(name, subnet["ip"], subnet["ipv6"] if "ipv6" in subnet else None)

@task
def netstop():
    """
    Removes all netwok devices specified in `env.settings.subnets`, requires tunctl
    """

    print("Stopping network")

    with mode_local():
        rmnet(env.settings["managment"]["name"])
        for name, subnet in env.settings["subnets"].iteritems():
            rmnet(name)

    print("Network stopped")

@task
def natstart(dev):
    """
    Creates nat on specified device and enables routing, requires iptables; params: dev

    :param dev: Name of network device where nat should be performed
    :type dev: str
    """

    print("Creating nat iptables rules")

    with mode_local():
        sudo("echo 1 > /proc/sys/net/ipv4/ip_forward")
        sudo("/sbin/iptables -t nat -A POSTROUTING -o %s -j MASQUERADE" %dev)
        sudo("/sbin/iptables -A FORWARD -j ACCEPT")
        sudo("echo 1 | sudo tee /proc/sys/net/ipv4/ip_forward")

    print("Nat iptables rules created")
