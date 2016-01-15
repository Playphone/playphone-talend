# == Class: talend::get
#
# Full description of class talend here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { talend:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Rik Schneider <rik@playphone.com>
#
# === Copyright
#
# Copyright 2016 Playphone, Inc, unless otherwise noted.
#
class talend::get(
  $options = {},
) {

  $defaults = {
    url_base      => 'http://localhost',
    name          => 'empty',
    extension     => 'zip',
    download_dir  => '/var/tmp/talend_download',
    extract_dir   => '/var/tmp/talend_installer',
    root_dir      => '',
  }

  $get_hash = merge($defaults,$options)


  archive { "${get_hash[name]}":
    ensure     => present,
    src_target => "${get_hash[download_dir]}",
    url        => "${get_hash[url_base]}/${get_hash[name]}.${get_hash[extension]}",
    target     => "${get_hash[extract_dir]}",
    extension  => "${get_hash[extension]}",
  }
}