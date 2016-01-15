# == Class: talend::db
#
# This class, talend::db, installs the metadata database for talend. 
#
# === Parameters
#
# [*options*]
#   Options is a hash used to override the default settings for this class.
#
# === Hash Keys
#
# [*name*]
#   The name of the database to install.
# [*user*]
# [*password*]
# [*host*]
# [*grant*]
#
# === Examples
#
#  class { talend::db:
#    options => {
#	   name => 'talend_administrator',
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
class talend::db(
  $options = {},
) {

  $defaults = {
    name     => 'talend_administrator',
    user     => 'myuser',
    password => 'mypass',
    host     => 'localhost',
    grant    => ['SELECT', 'UPDATE'],
  }

  $db_hash = merge($defaults,$options)

  mysql::db { "${db_hash[name]}":
    user     => "${db_hash[user]}",
    password => "${db_hash[password]}",
    host     => "${db_hash[host]}",
    grant    => "${db_hash[grant]}",
  }
}