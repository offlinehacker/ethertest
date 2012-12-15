#!/bin/bash -e

if [ ! -e ~/.bootstrap-vagrant ]; then
    cd /tmp

    wget http://apt.puppetlabs.com/puppetlabs-release-precise.deb
    dpkg -i puppetlabs-release-precise.deb
    apt-get update && apt-get -y install puppet

    touch ~/.bootstrap-vagrant
fi
