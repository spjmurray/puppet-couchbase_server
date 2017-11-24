# == Class: couchbase_server::service
#
# Manages the couchbase server service
#
class couchbase_server::service {

  service { 'couchbase-server':
    ensure => running,
  }

}
# vi: ts=2 et:
