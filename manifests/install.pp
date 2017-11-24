# == Class: couchbase_server::install
#
# Installs couchbase server
#
class couchbase_server::install {

  $_host = $::couchbase_server::packages
  $_path = "/releases/${::couchbase_server::version}/"

  $_os_family = $facts['os']['family']
  $_os_name = downcase($facts['os']['name'])
  $_os_version = $facts['os']['release']['full']

  case $_os_family {
    'Debian': {
      $_file = "couchbase-server-enterprise_${::couchbase_server::version}-${_os_name}${_os_version}_amd64.deb"
      $_provider = 'dpkg'
    }

    'RedHat': {
      $_file = "couchbase-server-enterprise-${::couchbase_server::version}-${_os_name}${_os_version}.x86_64.rpm"
      $_provider = 'rpm'
    }

    default: {
      fatal("Unsupported OS family \"${_os_family}\"")
    }
  }

  # TODO: Breaks idempotency as this is cleaned on bootstrap
  $_local_file = "/tmp/${_file}"
  $_url = "${_host}${_path}${_file}"

  # TODO: An actual supported apt/yum repository is more devops...
  file { 'couchbase-server':
    path   => $_local_file,
    source => $_url,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  } ->

  package { 'couchbase-server-enterprise':
    source   => $_local_file,
    provider => $_provider,
  }

}
# vi: ts=2 et:
