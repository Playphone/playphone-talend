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

  include wget

  $defaults = {
  	url_base  => 'http://localhost',
  	file_name => 'true',
  	path      => '/var/tmp',

  }

  $get_hash = merge($defaults,$options)

  notify { "${get_hash[url]}/${get_hash[file_name]}": }

  wget::fetch { "download the talend insaller file":
    source             => "${get_hash[url_base]}/${get_hash[file_name]}",
    destination        => "${get_hash[path]}/${get_hash[file_name]}",
    timeout            => 0,
    verbose            => true,
    nocheckcertificate => true,
  }


}