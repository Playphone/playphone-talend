# == Class: talend::get
#
# This class, talend::get, pulls in the talend installer and extracts it. 
#
# === Parameters
#
# [*options*]
#   Options is a hash used to override the default settings for this class.
#
# === Hash Keys
#
# [*url_base*]
#   The url of the directory where the talend archive file is located. 
# [*name*]
#   The base of the name of the installer archive.  This is used with the 
#   base_url and extension to populate a curl command.
# [*extension*]
#    The extension [zip, tar.gz, etc.] describing the archive type.
# [*download_dir*]
# [*extract_dir*]
# [*root_dir*]
#   Only used if the top directory name in the archive doesn't match
#   the value of $get_hash[name] 
#
# === Examples
#
#  class { talend::get:
#    options => {
#	   name => 'talend_installer',
#    }
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