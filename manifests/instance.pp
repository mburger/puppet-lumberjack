define lumberjack::instance (
  $files,
  $template       = 'lumberjack/lumberjack_instance.yaml.erb',
  $type           = $name,
  $enable         = 'true') {

  $ensure = bool2ensure($enable)

  include lumberjack

  concat::fragment { "lumberjack_process_${name}":
    ensure  => $ensure,
    order   => '02',
    target  => $lumberjack::config_file,
    content => template($template),
  }
}
