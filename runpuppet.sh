#!/bin/bash

export FACTER_middleware_ip="192.168.2.10"

sudo puppet apply \
  --pluginsync \
  --hiera_config /vagrant/deploy/hiera.yaml \
  --modulepath /vagrant/deploy/modules \
  /vagrant/deploy/site.pp
