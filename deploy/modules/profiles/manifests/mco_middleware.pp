#
class profiles::mco_middleware(
  $activemq_version    = $profiles::base_mco::activemq_version,
  $middleware_hostname = $profiles::base_mco::activemq_middleware_hostname,
) {

  class { 'java':
    distribution => 'jdk',
    version      => 'latest',
  } ->

  class { 'activemq':
    version => $activemq_version,
    require => File['/usr/libexec/mcollective'],
  }

  file { '/usr/share/activemq/activemq-data':
    ensure  => 'link',
    target  => '/var/cache/activemq/data',
    require => Class['activemq'],
  } ->

  class { '::mcollective':
    middleware_hosts => [$middleware_hostname],
    require          => Class['profiles::mco_base'],
  }

  if $::osfamily == 'Redhat' and (versioncmp($activemq_version, '5.9') < 0 or $activemq_version == 'present') {
    package { 'tanukiwrapper':
      ensure  => 'present',
      require => Class['activemq'],
    } ->

    file { '/usr/share/activemq/conf/activemq-wrapper.conf':
      ensure  => 'file',
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template('activemq/default/activemq-wrapper.conf'),
    }
  }


}
