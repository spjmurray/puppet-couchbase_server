# Vagrant Provisioning for Couchbase Server
#
# Consult .vagrantuser for configuration options
#
# Plugin Requirements:
# * nugrant (to support .vagrant user)
#
# Installing plugins:
# * vagrant plugin install nugrant
#

require 'yaml'

# Static mapping from distro/release to vbox
VBOXES = {
  'debian' => {
    '8' => 'debian/jessie64'
  },
  'ubuntu' => {
    '16.04' => 'ubuntu/xenial64'
  },
  'centos' => {
    '7' => 'centos/7'
  },
  'suse' => {
    '12' => 'suse/sles12sp3'
  }
}.freeze

# Static mapping from distro to family
FAMILIES = {
  'debian' => 'debian',
  'ubuntu' => 'debian',
  'centos' => 'redhat',
  'suse' => 'redhat'
}.freeze

# Provisioning scripts
SCRIPTS = {
  'debian' => 'vagrant/debian.sh'
}.freeze

Vagrant.configure('2') do |config|
  # Select the box type to spawn
  config.vm.box = VBOXES[config.user.os.dist] && VBOXES[config.user.os.dist][config.user.os.release]
  unless config.vm.box
    puts 'OS distribution and release not specified in .vagrantuser'
  end

  # Couchbase server should have at least 4GB RAM available
  config.vm.provider 'virtualbox' do |virtualbox, _|
    virtualbox.memory = 4096
  end

  # Ports to expose by default
  # 8091 - Web portal, REST API
  config.vm.network 'forwarded_port', guest: 8091, host: 8091, auto_correct: true

  # For every host we have defined in .vagrantuser define a new VM
  config.user.hosts.each_key do |host_name|
    config.vm.define host_name do |host|
      # All nodes get a family specific script applied to them.
      # This installs puppet etc. i.e. things not managed by or required by the module
      host.vm.provision 'shell', path: SCRIPTS[FAMILIES[config.user.os.dist]]

      # Use the .fixtures file defined for Rspec to source the dependencies we
      # need to install, this just minimises duplication
      fixtures = YAML.safe_load(File.read('.fixtures.yml'))
      fixtures['fixtures']['forge_modules'].each_value do |path|
        host.vm.provision 'shell', inline: "/opt/puppetlabs/bin/puppet module install #{path}"
      end

      # Install our module source into Puppet's environment
      config.vm.synced_folder '.', '/etc/puppetlabs/code/environments/production/modules/couchbase_server'

      # Provision couchbase
      host.vm.provision 'puppet' do |puppet|
        puppet.manifests_path = 'vagrant'
        puppet.manifest_file = 'site.pp'
      end
    end
  end
end
# vi: ts=2 et syntax=ruby:
