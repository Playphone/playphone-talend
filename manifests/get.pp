# == Class: talend::get
#
# This class, talend::get, pulls in the talend installer and license file,
# then extracts the installer.
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
# [*license_base_url*]
# [*license_file*]
#
# === Examples
#
#  class { talend::get:
#    options => {
#      name => 'talend_installer',
#    }
#  }
#
#
# === Bugs
#
#  archive::download and archive::extract seem to handle names differently.
#  I may need to split the calls up
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
    url_base         => 'http://localhost',
    name             => 'empty',
    extension        => 'zip',
    download_dir     => '/var/tmp/talend_download',
    extract_dir      => '/var/tmp/talend_installer',
    root_dir         => '',
    # License specific stuff.
    license_url_base => 'http://localhost',
    license_file     => 'talend.license',
  }

  $get_hash = merge($defaults,$options)

  file { ["${get_hash[download_dir]}", "${get_hash[extract_dir]}"]:
    ensure => directory,
    mode   => '0775',
    owner  => 'root',
    group  => 'root',
  }

  wget::fetch { "${get_hash[license_file]}":
    source      =>
      "${get_hash[license_url_base]}/${get_hash[license_file]}",
    destination => "${get_hash[extract_dir]}/${get_hash[license_file]}",
    timeout     => 0,
    verbose     => false,
  }

  wget::fetch { "${get_hash[name]}.${get_hash[extension]}":
    source      =>
      "${get_hash[url_base]}/${get_hash[name]}.${get_hash[extension]}",
    destination => "${get_hash[download_dir]}/${get_hash[name]}",
    timeout     => 0,
    verbose     => false,
  }->
  archive::extract  { "${get_hash[name]}":
    src_target => "${get_hash[download_dir]}",
    target     => "${get_hash[extract_dir]}",
    extension  => "${get_hash[extension]}",
    root_dir   => "${get_hash[root_dir]}"
  }
}