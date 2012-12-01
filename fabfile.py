# -*- coding: utf-8 -*-
"""
.. module:: fabfile.py
   :platform: Unix
   :synopsis: Different utils for configuring local testing network
"""

from jinja2 import Environment
from jinja2.loaders import FileSystemLoader

from fabric.api import task, env, run, sudo
from fabric.contrib.files import sed

from cuisine import *

env.path = "templates"

env.settings = {
    "managment": {
        "name": "manage",
        "ip": "192.168.0.1/24",
        "static": [{"mac":"08:00:27:12:96:98", "ip":"192.168.0.2"}],
        "dhcp_start": "192.168.0.10",
        "dhcp_stop": "192.168.0.255"
    },
    "subnets": {
        "ext": {
            "ip": "192.168.10.1/24",
        },
        "priv": {
            "ip": "10.1.0.2/16",
        },
        "prod": {
            "ip": "10.2.0.2/16",
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

    with mode_local():
        if not run("ifconfig %s"% name).succeeded:
            sudo("tunctl -g vboxusers -t %s" %name)

        sudo("ifconfig %s %s" %(name,ip4))
        sudo("ifconfig %s up" %name)

        if ip6:
            sudo("ip -6 addr add %s dev %s" %(ip6, name))

@task
def rmnet(name):
    """
    Removes virtual(tap) network device, requires tunctl command; params: name

    :param name: Name of network device
    :type name: str
    """

    with mode_local():
        sudo("ifconfig %s down" %name)
        sudo("tunctl -d %s" %name)

@task
def dhcp():
    """
    Starts dnsmasq dns server on managment interface, requires dnsmasq server
    """

    with mode_local():
        gen_template("dnsmasq.conf")
        if file_exists("/var/run/dnsmasq.pid"):
            print "dnsmasq is already running, killing it"
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
            print "dnsmasq is already running, killing it"
            sudo("kill %s" %run("cat /var/run/dnsmasq.pid"))
            sudo("rm /var/run/dnsmasq.pid")

@task
def netstart():
    """
    Creates all network devices specified in `env.settins.subnets`, requires tunctl
    """

    with mode_local():
        mknet(env.settings["managment"]["name"], env.settings["managment"]["ip"])
        for name, subnet in env.settings["subnets"].iteritems():
            mknet(name, subnet["ip"], subnet["ipv6"] if "ipv6" in subnet else None)

@task
def netstop():
    """
    Removes all netwok devices specified in `env.settings.subnets`, requires tunctl
    """

    with mode_local():
        rmnet(env.settings["managment"]["name"])
        for name, subnet in env.settings["subnets"].iteritems():
            rmnet(name)

@task
def natstart(dev):
    """
    Creates nat on specified device and enables routing, requires iptables; params: dev

    :param dev: Name of network device where nat should be performed
    :type dev: str
    """

    with mode_local():
        sudo("echo 1 > /proc/sys/net/ipv4/ip_forward")
        sudo("/sbin/iptables -t nat -A POSTROUTING -o %s -j MASQUERADE" %dev)
        sudo("/sbin/iptables -A FORWARD -j ACCEPT")
