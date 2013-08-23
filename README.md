# Puppet module: lumberjack

This is a Puppet module for lumberjack based on the second generation layout ("NextGen") of Example42 Puppet Modules.

Made by Markus Burger (based on the template provided by Alessandro Franceschi)

Released under the terms of Apache 2 License.

This module requires functions provided by the Example42 Puppi module (you need it even if you don't use and install Puppi)

For detailed info about the logic and usage patterns of Example42 modules check the DOCS directory on Example42 main modules set.


## USAGE - Basic management

* Install lumberjack with default settings

        class { 'lumberjack': }

* Install a specific version of lumberjack package

        class { 'lumberjack':
          version => '1.0.1',
        }

* Disable lumberjack service.

        class { 'lumberjack':
          disable => true
        }

* Remove lumberjack package

        class { 'lumberjack':
          absent => true
        }

* Enable auditing without without making changes on existing lumberjack configuration *files*

        class { 'lumberjack':
          audit_only => true
        }

* Module dry-run: Do not make any change on *all* the resources provided by the module

        class { 'lumberjack':
          noops => true
        }


## USAGE - Overrides and Customizations
* Use custom source directory for the whole configuration dir

        class { 'lumberjack':
          source_dir       => 'puppet:///modules/example42/lumberjack/conf/',
          source_dir_purge => false, # Set to true to purge any existing file not present in $source_dir
        }

* Automatically include a custom subclass

        class { 'lumberjack':
          my_class => 'example42::my_lumberjack',
        }


## USAGE - Example42 extensions management
* Activate puppi (recommended, but disabled by default)

        class { 'lumberjack':
          puppi    => true,
        }

* Activate puppi and use a custom puppi_helper template (to be provided separately with a puppi::helper define ) to customize the output of puppi commands 

        class { 'lumberjack':
          puppi        => true,
          puppi_helper => 'myhelper',
        }

* Activate automatic monitoring (recommended, but disabled by default). This option requires the usage of Example42 monitor and relevant monitor tools modules

        class { 'lumberjack':
          monitor      => true,
          monitor_tool => [ 'nagios' , 'monit' , 'munin' ],
        }

## CONTINUOUS TESTING

Travis {<img src="https://travis-ci.org/example42/puppet-lumberjack.png?branch=master" alt="Build Status" />}[https://travis-ci.org/example42/puppet-lumberjack]
