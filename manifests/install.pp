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
  $install_options  = {},
  $install_template ='talend/install.txt.erb',
  $install_command  =
    'Talend-Tools-Installer-20151214_1327-V6.1.1-linux-installer.run',
) {

  $install_defaults = {
    mode          => 'unattended',
  }

  $install_hash = merge($install_defaults,$install_options)

  $get = $talend::get::get_hash

  case $::osfamily {
    RedHat:{
      ensure_packages('rpm-build')
    }
  }

  file { "${get[extract_dir]}/install.txt":
    ensure  => file,
    mode    => '0664',
    owner   => talend,
    group   => talend,
    content => template($install_template),
  }->

  exec { 'Install Talend':
    command =>
      "${install_command} --optionfile=${get[extract_dir]}/install.txt && touch /var/tmp/installed",
    creates => '/var/tmp/installed',
  }
}