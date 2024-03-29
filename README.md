# beid

[![Build Status](https://travis-ci.org/yorickps/puppet-beid.svg?branch=master)](https://travis-ci.org/yorickps/puppet-beid)
[![Puppet Forge](https://img.shields.io/puppetforge/v/yorick/beid.svg)](https://forge.puppetlabs.com/yorick/beid)

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with beid](#setup)
    * [What beid affects](#what-beid-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with beid](#beginning-with-beid)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Description

This module installs [Belgian eID software](https://eid.belgium.be/en/linux-eid-software-installation).

It installs the "eid-archive" package, enabling the eID package repositories. Then it installs the "eid-viewer" and "eid-mw" packages. On Debian based distros it can install the Firefox exention as well.

This module uses the PDK, more info can be found on the [PDK readme](https://github.com/puppetlabs/pdk).

## Setup

### Beginning with beid

`include ::beid` should be enough to get it up and running.

## Usage

All parameters for the beid module are contained within the main `::beid` class, so for any function of the module, set the options you want.

## Reference

### Classes

#### Public classes

`beid`: Main class, includes all other.

#### Private classes

- `beid::install`: Installs all packages and dependencies
- `beid::service`: Handles the systemd service

### Parameters

Following parameters are available, and are the defaults:

#### Common

```yaml
beid::download_url: https://eid.belgium.be/sites/default/files/software
beid::package_ensure: 'present'
beid::package_manage: true
beid::service_enable: true
beid::service_ensure: 'running'
beid::service_manage: true
beid::service_name: 'pcscd'
beid::browser_packages: []
```

#### Debian family

```yaml
beid::version: '2018.3'
beid::package_archive: "eid-archive_%{lookup('beid::version')}_all.deb"
beid::service_package: 'pcscd'
beid::browser_packages_manage: true
beid::firefox_extension_manage: true
beid::packages:
  - eid-viewer
  - eid-mw
beid::browser_packages:
  - default-jre
beid::firefox_extension: 'beid-mozilla-extension'
beid::package_archive_name: 'eid-archive'
```

#### RedHat family

```yaml
beid::package_archive: "eid-archive-el-%{lookup('beid::version')}.noarch.rpm"
beid::version: '2016-2'
beid::service_package: 'pcscd-tools'
beid::packages:
  - eid-archive-el
  - eid-viewer
  - eid-mw
```

#### Fedora

```yaml
beid::package_archive: eid-archive-fedora-%{lookup('beid::version')}.noarch.rpm
beid::version: '2016-2'
beid::packages:
  - eid-archive-fedora
  - eid-viewer
  - eid-mw
beid::package_archive_name: 'eid-archive-fedora'
```

## Limitations

This module has been tested on Debian 'stretch' and Fedora 27. CentOS 7 and distros based on Debian (e.g. Ubuntu 16.04) should work as well.

This module does ***not*** cover the installation of the smart card reader. More info can be found on the
[eiD FAQ](http://test.eid.belgium.be/faq/faq_nl.htm) from the Belgian governement and the [Debian Smartcards wiki](https://wiki.debian.org/Smartcards).


## Development

## Contributing

Read more in the [Contributing section](CONTRIBUTING.md).

## Release Notes/Contributors/Etc.
