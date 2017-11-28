#!/bin/bash -x

PROVISONED='/tmp/.provisioned'

test -f ${PROVISONED} && exit 0

# Required to extract the distribution code name before Facter is available
source /etc/lsb-release

# Install Puppet's GPG signing key
wget -q -O- http://apt.puppet.com/pubkey.gpg | apt-key add -

# Install a link to the Puppet apt repository
echo "deb http://apt.puppet.com/ ${DISTRIB_CODENAME} puppet5" > /etc/apt/sources.list.d/puppet.list

# Install Puppet
apt-get update
apt-get -y install puppet-agent

# Install python
# TODO: Perhaps make a module prerequisite package?  (Wait until RedHat is tested...)
apt-get -y install python python-httplib2

# Set swappiness to 0
# TODO: Again make part of the module?
echo 'vm.swappiness = 0' >> /etc/sysctl.conf
sysctl -p

touch ${PROVISONED}

# vi: ts=2 et:
