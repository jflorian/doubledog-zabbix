#
# == Class: zabbix::agent
#
# Manages the Zabbix agent on a host.
#
# === Parameters
#
# ==== Required
#
# ==== Optional
#
# [*enable*]
#   Instance is to be started at boot.  Either true (default) or false.
#
# [*ensure*]
#   Instance is to be 'running' (default) or 'stopped'.  Alternatively,
#   a Boolean value may also be used with true equivalent to 'running' and
#   false equivalent to 'stopped'.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# This file is part of the doubledog-zabbix Puppet module.
# Copyright 2017-2018 John Florian
# SPDX-License-Identifier: GPL-3.0-or-later


class zabbix::agent (
        String                  $conf_file,
        Boolean                 $enable,
        Ddolib::Service::Ensure $ensure,
        Boolean                 $manage_firewall,
        Array[String]           $packages,
        String                  $server_ip,
        Integer[1,65535]        $listen_port,
        Array[String]           $services,
    ) {

    package { $::zabbix::agent::packages:
        ensure => installed,
        notify => Service[$::zabbix::agent::services],
    }

    file {
        default:
            owner     => 'root',
            group     => 'root',
            mode      => '0644',
            seluser   => 'system_u',
            selrole   => 'object_r',
            seltype   => 'etc_t',
            before    => Service[$::zabbix::agent::services],
            notify    => Service[$::zabbix::agent::services],
            subscribe => Package[$::zabbix::agent::packages],
            ;
        '/etc/zabbix/zabbix_agentd.d':
            ensure => directory,
            ;
        $conf_file:
            content => template('zabbix/zabbix_agentd.conf.erb'),
            ;
    }

    if $manage_firewall {
        firewall {
            '300 accept Zabbix server':
                source => $server_ip,
                dport  => $listen_port,
                proto  => 'tcp',
                state  => 'NEW',
                action => 'accept',
                ;
        }
    }

    service { $::zabbix::agent::services:
        ensure     => $ensure,
        enable     => $enable,
        hasrestart => true,
        hasstatus  => true,
    }

}
