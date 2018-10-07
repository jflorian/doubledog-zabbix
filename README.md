<!--
This file is part of the doubledog-zabbix Puppet module.
Copyright 2018 John Florian <jflorian@doubledog.org>
SPDX-License-Identifier: GPL-3.0-or-later
-->

# zabbix

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with zabbix](#setup)
    * [What zabbix affects](#what-zabbix-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with zabbix](#beginning-with-zabbix)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
    * [Classes](#classes)
    * [Defined types](#defined-types)
    * [Data types](#data-types)
    * [Facts](#facts)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

This module lets you manage zabbix.

## Setup

### What zabbix Affects

### Setup Requirements

### Beginning with zabbix

## Usage

## Reference

**Classes:**

**Defined types:**

**Data types:**

**Facts:**


### Classes

### Defined types

### Data types

### Facts


## Limitations

Tested on modern Fedora and CentOS releases, but likely to work on any Red Hat variant.  Adaptations for other operating systems should be trivial as this module follows the data-in-module paradigm.  See `data/common.yaml` for the most likely obstructions.  If "one size can't fit all", the value should be moved from `data/common.yaml` to `data/os/%{facts.os.name}.yaml` instead.  See `hiera.yaml` for how this is handled.

## Development

Contributions are welcome via pull requests.  All code should generally be compliant with puppet-lint.
