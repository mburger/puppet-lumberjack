# Class: lumberjack::params
#
# This class defines default parameters used by the main module class lumberjack
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to lumberjack class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class lumberjack::params {

  ### Application related parameters

  $package = $::operatingsystem ? {
    default => 'lumberjack',
  }

  $package_provider = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => 'dpkg',
    default                   => '',
  }

  $package_source = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => 'puppet:///modules/lumberjack/lumberjack_0.1.2_amd64.deb',
    default                   => '',
  }

  $service = $::operatingsystem ? {
    default => 'lumberjack',
  }

  $service_status = $::operatingsystem ? {
    default => true,
  }

  $process = $::operatingsystem ? {
    default => 'lumberjack',
  }

  $process_args = $::operatingsystem ? {
    default => '',
  }

  $process_user = $::operatingsystem ? {
    default => 'root',
  }

  $config_dir = $::operatingsystem ? {
    default => '/etc/lumberjack',
  }

  $config_file = $::operatingsystem ? {
    default => '/etc/lumberjack/lumberjack.yaml',
  }

  $config_file_json = $::operatingsystem ? {
    default => '/etc/lumberjack/lumberjack.json',
  }

  $config_file_mode = $::operatingsystem ? {
    default => '0644',
  }

  $config_file_owner = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_group = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_init = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/etc/default/lumberjack',
    default                   => '/etc/sysconfig/lumberjack',
  }

  $init_template = $::operatingsystem ? {
    default => 'lumberjack/lumberjack_init.erb'
  }

  $pid_file = $::operatingsystem ? {
    default => '/var/run/lumberjack.pid',
  }

  # General Settings
  $my_class = ''
  $install = 'package'
  $install_destination = '/opt'
  $source_dir = ''
  $source_dir_purge = false
  $options = ''
  $service_autorestart = true
  $version = 'present'
  $absent = false
  $disable = false
  $disableboot = false
  $ssl_client_cert = ''
  $ssl_client_key = ''
  $ssl_ca = ''
  $convert_yaml_to_json = true

  ### General module variables that can have a site or per module default
  $monitor = false
  $monitor_tool = ''
  $monitor_target = $::ipaddress
  $puppi = false
  $puppi_helper = 'standard'
  $debug = false
  $audit_only = false
  $noops = false

}
