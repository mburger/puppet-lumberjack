#Class: lumberjack::config
#
# This class manages lumberjack configuration
#
# == Variables
#
# Refer to lumberjack class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It's automatically included by lumberjack
#
class lumberjack::config ( ) {

  # The whole lumberjack configuration directory can be recursively overriden
  if $lumberjack::source_dir {
    file { 'lumberjack.dir':
      ensure  => directory,
      path    => $lumberjack::config_dir,
      notify  => $lumberjack::manage_service_autorestart,
      source  => $lumberjack::source_dir,
      recurse => true,
      purge   => $lumberjack::bool_source_dir_purge,
      force   => $lumberjack::bool_source_dir_purge,
      replace => $lumberjack::manage_file_replace,
      audit   => $lumberjack::manage_audit,
      noop    => $lumberjack::bool_noops,
    }
  }
  else {
    file { 'lumberjack.dir':
      ensure  => $lumberjack::data_dir_ensure,
      path    => $lumberjack::config_dir,
      replace => $lumberjack::manage_file_replace,
      audit   => $lumberjack::manage_audit,
      noop    => $lumberjack::bool_noops,
    }

    include concat::setup

    concat { $lumberjack::config_file:
      mode    => $lumberjack::config_file_mode,
      owner   => $lumberjack::config_file_owner,
      group   => $lumberjack::config_file_group,
      notify  => $lumberjack::manage_convert_yaml_to_json,
    }

    concat::fragment { 'lumberjack_header':
      ensure  => present,
      order   => '01',
      target  => $lumberjack::config_file,
      content => template('lumberjack/lumberjack_header.yaml.erb'),
      require => File['lumberjack.dir'],
    }
  }
}
