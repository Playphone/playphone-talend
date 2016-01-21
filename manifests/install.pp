# == Class: talend::install
#
# This class, talend::install, creates the talend installer config file and
# executes it.
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
#   the value of $install_hash[name]
#
# === Examples
#
#  class { talend::install:
#    options => {
#    name => 'talend_installer',
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
class talend::install(
  $install_options = {},
) {

  $install_defaults = {
    mode          => 'unattended',
  }

  $install_hash = merge($install_defaults,$install_options)

  case $::osfamily {
    RedHat:{
      ensure_packages('rpm-build')
    }
  }

  file { '/var/tmp/talend_installer/install.txt':
    ensure  => file,
    mode    => '0664',
    owner   => talend,
    group   => talend,
    content => template('talend/install.txt.erb'),
  }



}