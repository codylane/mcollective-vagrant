#
class profiles::mco_base(
  $activemq_version    = hiera('activemq::version', '5.9.1-2.el6'),
  $middleware_hostname = 'middleware.cmfl2.net',
  $middleware_ip       = '192.168.2.10',
  $type                = $::hostname,
) {

  file { '/usr/libexec/mcollective':
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  case $type {
    'middleware': {
      class { 'profiles::mco_middleware':
        activemq_version    => $activemq_version,
        middleware_hostname => $middleware_hostname,
      }
    }

    /server|node[0-9]+/: {
      notify { "executing server setup": }
      class { 'profiles::mco_server':
        middleware_hostname => $middleware_hostname,
        middleware_ip       => $middleware_ip,
      }
    }

    default: {
      fail("Unsupported type ${type} on module ${module_name}")
    }
  }

}
