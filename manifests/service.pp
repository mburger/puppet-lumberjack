# Class: lumberjack::service
#
# This class manages lumberjack services
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
class lumberjack::service inherits lumberjack {

  service { 'lumberjack':
    ensure     => $lumberjack::manage_service_ensure,
    name       => $lumberjack::service,
    enable     => $lumberjack::manage_service_enable,
    hasstatus  => $lumberjack::service_status,
    pattern    => $lumberjack::process,
    noop       => $lumberjack::bool_noops,
  }
}
