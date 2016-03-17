node default {
  $activemq_version    = hiera('activemq::version', '5.9.1-2.el6')
  $middleware_hostname = 'middleware.cmfl2.net'
  $middleware_ip       = '192.168.2.10'

  if $::osfamily == 'Redhat' and (versioncmp($activemq_version, '5.9') < 0 or $activemq_version == 'present') {
    package { 'tanukiwrapper':
      ensure => 'present',
    } ->

    file { '/usr/share/activemq/conf/activemq-wrapper.conf':
      ensure  => 'file',
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template('activemq/default/activemq-wrapper.conf'),
    }
  }

  file { '/usr/libexec/mcollective':
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  if $::hostname == 'middleware' {
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
      require          => File['/usr/libexec/mcollective'],
    }

  } else {

    host { $middleware_hostname:
      ensure => 'present',
      ip     => $middleware_ip,
    } ->

    class { '::mcollective':
      middleware_hosts => [$middleware_hostname],
      client           => true,
      require          => File['/usr/libexec/mcollective'],
    }
  }
}
