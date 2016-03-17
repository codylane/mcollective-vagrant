#
class profiles::mco_server(
  $middleware_hostname = $profiles::mco_base::middleware_hostname,
  $middleware_ip       = $profiles::mco_base::middleware_ip,
) {

  if $::productname == 'VirtualBox' {
    host { $middleware_hostname:
      ensure => 'present',
      ip     => $middleware_ip,
    }
  }

  class { '::mcollective':
    middleware_hosts => [$middleware_hostname],
    client           => true,
    require          => Class['profiles::mco_base'],
  }
}
