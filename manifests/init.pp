# == Class: couchbase_server
#
# Installs couchbase server
#
class couchbase_server (
  String $packages = 'http://packages.couchbase.com',
  String $version = '5.0.0',
) {

  include ::couchbase_server::install
  include ::couchbase_server::service

  Class['::couchbase_server::install'] ~>
  Class['::couchbase_server::service']

}
# vi: ts=2 et:
