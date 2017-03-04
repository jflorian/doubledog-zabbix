# git_modules/zabbix/manifests/server.pp
#
# == Class: zabbix::server
#
# Manages the Zabbix server on a host.
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
# Copyright 2017 John Florian


class zabbix::server (
        String $conf_file,
        String $db_host,
        String $db_name,
        String $db_user,
        String $db_passwd,
        Boolean $enable,
        Variant[Boolean, Enum['running', 'stopped']] $ensure,
        Boolean $manage_firewall,
        Array[String] $packages,
        Integer[1,65535] $listen_port,
        Array[String] $services,
        String $timezone,
    ) {

    package { $::zabbix::server::packages:
        ensure => installed,
        notify => Service[$::zabbix::server::services],
    }

    file {
        default:
            owner     => 'root',
            group     => 'zabbix',
            mode      => '0640',
            seluser   => 'system_u',
            selrole   => 'object_r',
            seltype   => 'etc_t',
            before    => Service[$::zabbix::server::services],
            notify    => Service[$::zabbix::server::services],
            subscribe => Package[$::zabbix::server::packages],
            ;
        $conf_file:
            content   => template('zabbix/zabbix_server.conf.erb'),
            show_diff => false,
            ;
    }

    ::apache::site_config { 'zabbix':
        content => template('zabbix/httpd-zabbix.conf.erb'),
    }

    if $manage_firewall {
        firewall {
            '300 accept Zabbix agent':
                dport  => $listen_port,
                proto  => 'tcp',
                state  => 'NEW',
                action => 'accept',
                ;
        }
    }

    service { $::zabbix::server::services:
        ensure     => $ensure,
        enable     => $enable,
        hasrestart => true,
        hasstatus  => true,
    }

}
