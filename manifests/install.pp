# Class: lumberjack::install
#
# This class installs lumberjack
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
class lumberjack::install inherits lumberjack {

  case $lumberjack::install {

    package: {

      if ($lumberjack::package_source != '') or ($lumberjack::package_source == undef) {
        case $lumberjack::package_source {
          /^http/: {
            exec {
              "wget lumberjack package":
                command => "wget -O ${lumberjack::real_package_path} ${lumberjack::package_source}",
                creates => "${lumberjack::real_package_path}",
                unless  => "test -f ${lumberjack::real_package_path}",
                before  => Package['lumberjack']
            }
          }
          /^puppet/: {
            file {
              'lumberjack package':
                path    => "${lumberjack::real_package_path}",
                ensure  => $lumberjack::manage_file,
                source  => $lumberjack::package_source,
                before  => Package['lumberjack']
            }
          }
          default: {}
        }
      }

      package { 'lumberjack':
        ensure    => $lumberjack::manage_package,
        name      => $lumberjack::package,
        provider  => $lumberjack::real_package_provider,
        source    => $lumberjack::real_package_path,
        noop      => $lumberjack::bool_noops,
      }
    }

    default: {}
  }

  if $lumberjack::config_file_init {
    file { 'lumberjack.init':
      ensure  => $lumberjack::manage_file,
      path    => $lumberjack::config_file_init,
      mode    => $lumberjack::config_file_mode,
      owner   => $lumberjack::config_file_owner,
      group   => $lumberjack::config_file_group,
      require => Package['lumberjack'],
      notify  => $lumberjack::manage_service_autorestart,
      source  => $lumberjack::manage_file_init_source,
      content => $lumberjack::manage_file_init_content,
      replace => $lumberjack::manage_file_replace,
      audit   => $lumberjack::manage_audit,
    }
  }
}
