require 'spec_helper'

describe 'couchbase_server', :type => :class do
  let :params do
    {
      :version => '5.0.0'
    }
  end

  context 'on an ubuntu system' do
    let :facts do
      {
        :os => {
          :family => 'Debian',
          :name => 'Ubuntu',
          :release => {
            :full => '16.04'
          }
        }
      }
    end

    context 'couchbase_server::install' do
      it 'contains a valid package name' do
        is_expected.to contain_file('couchbase-server').with(
          'path' => '/tmp/couchbase-server-enterprise_5.0.0-ubuntu16.04_amd64.deb'
        )
      end
    end
  end

  context 'on a debian system' do
    let :facts do
      {
        :os => {
          :family => 'Debian',
          :name => 'Debian',
          :release => {
            :full => '7'
          }
        }
      }
    end

    context 'couchbase_server::install' do
      it 'contains a valid package name' do
        is_expected.to contain_file('couchbase-server').with(
          'path' => '/tmp/couchbase-server-enterprise_5.0.0-debian7_amd64.deb'
        )
      end
    end
  end

  context 'on a centos system' do
    let :facts do
      {
        :os => {
          :family => 'RedHat',
          :name => 'CentOS',
          :release => {
            :full => '7'
          }
        }
      }
    end

    context 'couchbase_server::install' do
      it 'contains a valid package name' do
        is_expected.to contain_file('couchbase-server').with(
          'path' => '/tmp/couchbase-server-enterprise-5.0.0-centos7.x86_64.rpm'
        )
      end
    end
  end

  context 'on an opensuse system' do
    let :facts do
      {
        :os => {
          :family => 'RedHat',
          :name => 'SuSE',
          :release => {
            :full => '12'
          }
        }
      }
    end

    context 'couchbase_server::install' do
      it 'contains a valid package name' do
        is_expected.to contain_file('couchbase-server').with(
          'path' => '/tmp/couchbase-server-enterprise-5.0.0-suse12.x86_64.rpm'
        )
      end
    end
  end
end

# vi: ts=2 et:
