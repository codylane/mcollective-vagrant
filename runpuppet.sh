#!/bin/bash

export FACTER_middleware_pi="192.168.2.10"

sudo puppet apply --modulepath /vagrant/deploy/modules apply -e '
  class { "java":
	distribution => 'jdk',
	version      => 'latest',
  }
'

sudo puppet apply \
  --pluginsync \
  --hiera_config /vagrant/deploy/hiera.yaml \
  --modulepath /vagrant/deploy/modules \
  /vagrant/deploy/site.pp
