# = Class: lumberjack
#
# This is the main lumberjack class
#
#
# == Parameters
#
# Standard class parameters
# Define the general class behaviour and customizations
#
# [*my_class*]
#   Name of a custom class to autoload to manage module's customizations
#   If defined, lumberjack class will automatically "include $my_class"
#   Can be defined also by the (top scope) variable $lumberjack_myclass
#
# [*source*]
#   Sets the content of source parameter for main configuration file
#   If defined, lumberjack main config file will have the param: source => $source
#   Can be defined also by the (top scope) variable $lumberjack_source
#
# [*source_dir*]
#   If defined, the whole lumberjack configuration directory content is retrieved
#   recursively from the specified source
#   (source => $source_dir , recurse => true)
#   Can be defined also by the (top scope) variable $lumberjack_source_dir
#
# [*source_dir_purge*]
#   If set to true (default false) the existing configuration directory is
#   mirrored with the content retrieved from source_dir
#   (source => $source_dir , recurse => true , purge => true)
#   Can be defined also by the (top scope) variable $lumberjack_source_dir_purge
#
# [*template*]
#   Sets the path to the template to use as content for main configuration file
#   If defined, lumberjack main config file has: content => content("$template")
#   Note source and template parameters are mutually exclusive: don't use both
#   Can be defined also by the (top scope) variable $lumberjack_template
#
# [*options*]
#   An hash of custom options to be used in templates for arbitrary settings.
#   Can be defined also by the (top scope) variable $lumberjack_options
#
# [*service_autorestart*]
#   Automatically restarts the lumberjack service when there is a change in
#   configuration files. Default: true, Set to false if you don't want to
#   automatically restart the service.
#
# [*version*]
#   The package version, used in the ensure parameter of package type.
#   Default: present. Can be 'latest' or a specific version number.
#   Note that if the argument absent (see below) is set to true, the
#   package is removed, whatever the value of version parameter.
#
# [*absent*]
#   Set to 'true' to remove package(s) installed by module
#   Can be defined also by the (top scope) variable $lumberjack_absent
#
# [*disable*]
#   Set to 'true' to disable service(s) managed by module
#   Can be defined also by the (top scope) variable $lumberjack_disable
#
# [*disableboot*]
#   Set to 'true' to disable service(s) at boot, without checks if it's running
#   Use this when the service is managed by a tool like a cluster software
#   Can be defined also by the (top scope) variable $lumberjack_disableboot
#
# [*monitor*]
#   Set to 'true' to enable monitoring of the services provided by the module
#   Can be defined also by the (top scope) variables $lumberjack_monitor
#   and $monitor
#
# [*monitor_tool*]
#   Define which monitor tools (ad defined in Example42 monitor module)
#   you want to use for lumberjack checks
#   Can be defined also by the (top scope) variables $lumberjack_monitor_tool
#   and $monitor_tool
#
# [*monitor_target*]
#   The Ip address or hostname to use as a target for monitoring tools.
#   Default is the fact $ipaddress
#   Can be defined also by the (top scope) variables $lumberjack_monitor_target
#   and $monitor_target
#
# [*puppi*]
#   Set to 'true' to enable creation of module data files that are used by puppi
#   Can be defined also by the (top scope) variables $lumberjack_puppi and $puppi
#
# [*puppi_helper*]
#   Specify the helper to use for puppi commands. The default for this module
#   is specified in params.pp and is generally a good choice.
#   You can customize the output of puppi commands for this module using another
#   puppi helper. Use the define puppi::helper to create a new custom helper
#   Can be defined also by the (top scope) variables $lumberjack_puppi_helper
#   and $puppi_helper
#
# [*debug*]
#   Set to 'true' to enable modules debugging
#   Can be defined also by the (top scope) variables $lumberjack_debug and $debug
#
# [*audit_only*]
#   Set to 'true' if you don't intend to override existing configuration files
#   and want to audit the difference between existing files and the ones
#   managed by Puppet.
#   Can be defined also by the (top scope) variables $lumberjack_audit_only
#   and $audit_only
#
# [*noops*]
#   Set noop metaparameter to true for all the resources managed by the module.
#   Basically you can run a dryrun for this specific module if you set
#   this to true. Default: false
#
# Default class params - As defined in lumberjack::params.
# Note that these variables are mostly defined and used in the module itself,
# overriding the default values might not affected all the involved components.
# Set and override them only if you know what you're doing.
# Note also that you can't override/set them via top scope variables.
#
# [*package*]
#   The name of lumberjack package
#
# [*service*]
#   The name of lumberjack service
#
# [*service_status*]
#   If the lumberjack service init script supports status argument
#
# [*process*]
#   The name of lumberjack process
#
# [*process_args*]
#   The name of lumberjack arguments. Used by puppi and monitor.
#   Used only in case the lumberjack process name is generic (java, ruby...)
#
# [*process_user*]
#   The name of the user lumberjack runs with. Used by puppi and monitor.
#
# [*config_dir*]
#   Main configuration directory. Used by puppi
#
# [*config_file*]
#   Main configuration file path
#
# [*config_file_mode*]
#   Main configuration file path mode
#
# [*config_file_owner*]
#   Main configuration file path owner
#
# [*config_file_group*]
#   Main configuration file path group
#
# [*pid_file*]
#   Path of pid file. Used by monitor
#
# [*data_dir*]
#   Path of application data directory
#
# See README for usage patterns.
#
class lumberjack (
  $my_class            = params_lookup( 'my_class' ),
  $install             = params_lookup( 'install' ),
  $install_destination = params_lookup( 'install_destination' ),
  $source_dir          = params_lookup( 'source_dir' ),
  $source_dir_purge    = params_lookup( 'source_dir_purge' ),
  $service_autorestart = params_lookup( 'service_autorestart' , 'global' ),
  $options             = params_lookup( 'options' ),
  $version             = params_lookup( 'version' ),
  $absent              = params_lookup( 'absent' ),
  $disable             = params_lookup( 'disable' ),
  $disableboot         = params_lookup( 'disableboot' ),
  $monitor             = params_lookup( 'monitor' , 'global' ),
  $monitor_tool        = params_lookup( 'monitor_tool' , 'global' ),
  $monitor_target      = params_lookup( 'monitor_target' , 'global' ),
  $puppi               = params_lookup( 'puppi' , 'global' ),
  $puppi_helper        = params_lookup( 'puppi_helper' , 'global' ),
  $debug               = params_lookup( 'debug' , 'global' ),
  $audit_only          = params_lookup( 'audit_only' , 'global' ),
  $noops               = params_lookup( 'noops' ),
  $package             = params_lookup( 'package' ),
  $package_provider    = params_lookup( 'package_provider' ),
  $package_path        = params_lookup( 'package_path' ),
  $package_source      = params_lookup( 'package_source' ),
  $service             = params_lookup( 'service' ),
  $service_status      = params_lookup( 'service_status' ),
  $process             = params_lookup( 'process' ),
  $process_args        = params_lookup( 'process_args' ),
  $process_user        = params_lookup( 'process_user' ),
  $config_dir          = params_lookup( 'config_dir' ),
  $config_file         = params_lookup( 'config_file' ),
  $config_file_init         = params_lookup( 'config_file_init' ),
  $config_file_json    = params_lookup( 'config_file_json' ),
  $config_file_mode    = params_lookup( 'config_file_mode' ),
  $config_file_owner   = params_lookup( 'config_file_owner' ),
  $config_file_group   = params_lookup( 'config_file_group' ),
  $init_source         = params_lookup( 'init_source' ),
  $init_template       = params_lookup( 'init_template' ),
  $pid_file            = params_lookup( 'pid_file' ),
  $logstash_servers    = params_lookup( 'logstash_servers' ),
  $ssl_client_cert     = params_lookup( 'ssl_client_cert' ),
  $ssl_client_cert_path = params_lookup( 'ssl_client_cert_path' ),
  $ssl_client_key      = params_lookup( 'ssl_client_key' ),
  $ssl_client_key_path  = params_lookup( 'ssl_client_key_path' ),
  $ssl_ca              = params_lookup( 'ssl_ca' ),
  $ssl_ca_path         = params_lookup( 'ssl_ca_path' ),
  $convert_yaml_to_json = params_lookup( 'convert_yaml_to_json' )
  ) inherits lumberjack::params {

  $bool_source_dir_purge=any2bool($source_dir_purge)
  $bool_service_autorestart=any2bool($service_autorestart)
  $bool_absent=any2bool($absent)
  $bool_disable=any2bool($disable)
  $bool_disableboot=any2bool($disableboot)
  $bool_monitor=any2bool($monitor)
  $bool_puppi=any2bool($puppi)
  $bool_debug=any2bool($debug)
  $bool_audit_only=any2bool($audit_only)
  $bool_noops=any2bool($noops)
  $bool_convert_yaml_to_json=any2bool($convert_yaml_to_json)

  ### Definition of some variables used in the module
  $manage_package = $lumberjack::bool_absent ? {
    true  => 'absent',
    false => $lumberjack::version,
  }

  $manage_service_enable = $lumberjack::bool_disableboot ? {
    true    => false,
    default => $lumberjack::bool_disable ? {
      true    => false,
      default => $lumberjack::bool_absent ? {
        true  => false,
        false => true,
      },
    },
  }

  $manage_service_ensure = $lumberjack::bool_disable ? {
    true    => 'stopped',
    default =>  $lumberjack::bool_absent ? {
      true    => 'stopped',
      default => 'running',
    },
  }

  $manage_service_autorestart = $lumberjack::bool_service_autorestart ? {
    true    => Service[lumberjack],
    false   => undef,
  }

  # Crude Hack .....
  $manage_convert_yaml_to_json = $lumberjack::bool_convert_yaml_to_json ? {
    true    => Exec['lumberjack.json'],
    false   => undef,
  }

  $manage_file = $lumberjack::bool_absent ? {
    true    => 'absent',
    default => 'present',
  }

  if $lumberjack::bool_absent == true
  or $lumberjack::bool_disable == true
  or $lumberjack::bool_disableboot == true {
    $manage_monitor = false
  } else {
    $manage_monitor = true
  }

  $manage_audit = $lumberjack::bool_audit_only ? {
    true  => 'all',
    false => undef,
  }

  $manage_file_replace = $lumberjack::bool_audit_only ? {
    true  => false,
    false => true,
  }

  $manage_file_init_source = $lumberjack::init_source ? {
    '' => undef,
    default => $lumberjack::init_source,
  }

  $manage_file_init_content = $lumberjack::init_template ? {
    '' => undef,
    default => template($lumberjack::init_template),
  }

  $data_dir_ensure = $lumberjack::bool_absent ? {
    true  => 'absent',
    false => 'directory',
  }

  $package_filename = url_parse($lumberjack::package_source, 'filename')
  $real_package_path = $lumberjack::package_path ? {
    ''      => $lumberjack::package_source ? {
      ''      => undef,
      default => "${lumberjack::install_destination}/${lumberjack::package_filename}",
    },
    default => $lumberjack::package_path,
  }

  $real_package_provider = $lumberjack::package_provider ? {
    ''      => $lumberjack::package_source ? {
      ''      => undef,
      default => $::operatingsystem ? {
          /(?i:Debian|Ubuntu|Mint)/ => 'dpkg',
          default                   => undef,
      },
    },
    default => $lumberjack::package_provider,
  }

  ### Managed resources
  class { 'lumberjack::install': }
  class { 'lumberjack::config':
    require => Class['lumberjack::install']
  }
  class { 'lumberjack::service':
    require => Class['lumberjack::config']
  }

  if !defined(Package[json]) {
    package { 'json':
      ensure    => $lumberjack::manage_package,
      provider  => gem,
    }
  }

  exec { 'lumberjack.json':
    command     => "ruby -ryaml -rjson -e \"puts YAML::load_file('${lumberjack::config_file}').to_json\" > '${lumberjack::config_file_json}'",
    refreshonly => true,
    notify      => $lumberjack::manage_service_autorestart,
  }


  ### Include custom class if $my_class is set
  if $lumberjack::my_class {
    include $lumberjack::my_class
  }


  ### Provide puppi data, if enabled ( puppi => true )
  if $lumberjack::bool_puppi == true {
    $classvars=get_class_args()
    puppi::ze { 'lumberjack':
      ensure    => $lumberjack::manage_file,
      variables => $classvars,
      helper    => $lumberjack::puppi_helper,
      noop      => $lumberjack::bool_noops,
    }
  }


  ### Service monitoring, if enabled ( monitor => true )
  if $lumberjack::bool_monitor == true {
    if $lumberjack::service != '' {
      monitor::process { 'lumberjack_process':
        process  => $lumberjack::process,
        service  => $lumberjack::service,
        pidfile  => $lumberjack::pid_file,
        user     => $lumberjack::process_user,
        argument => $lumberjack::process_args,
        tool     => $lumberjack::monitor_tool,
        enable   => $lumberjack::manage_monitor,
        noop     => $lumberjack::bool_noops,
      }
    }
  }


  ### Debugging, if enabled ( debug => true )
  if $lumberjack::bool_debug == true {
    file { 'debug_lumberjack':
      ensure  => $lumberjack::manage_file,
      path    => "${settings::vardir}/debug-lumberjack",
      mode    => '0640',
      owner   => 'root',
      group   => 'root',
      content => inline_template('<%= scope.to_hash.reject { |k,v| k.to_s =~ /(uptime.*|path|timestamp|free|.*password.*|.*psk.*|.*key)/ }.to_yaml %>'),
      noop    => $lumberjack::bool_noops,
    }
  }

}
