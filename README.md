# beid

Welcome to your new module. A short overview of the generated parts can be found in the PDK documentation at https://puppet.com/pdk/latest/pdk_generating_modules.html .

The README template below provides a starting point with details about what information to include in your README.

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

## Setup

### What beid affects **OPTIONAL**

If it's obvious what your module touches, you can skip this section. For example, folks can probably figure out that your mysql_instance module affects their MySQL instances.

If there's more that they should know about, though, this is the place to mention:

* Files, packages, services, or operations that the module will alter, impact, or execute.
* Dependencies that your module automatically installs.
* Warnings or other important notices.

### Setup Requirements **OPTIONAL**

### Beginning with beid

`include ::beid` should be enough to get it up and running.

## Usage

All parameters for the beid module are contained within the main ::beid class, so for any function of the module, set the options you want.

## Reference

### Classes

#### Public classes

beid: Main class, includes all other.

#### Private classes

- beid::install: Installs all packages and dependencies
- beid::service: Handles the systemd service

### Parameters

Following parameters are available, and are the defaults:

#### Common

```yaml
beid::download_url: https://eid.belgium.be/sites/default/files/software
beid::manage_service: true
beid::package_ensure: 'present'
beid::package_manage: true
beid::service_enable: true
beid::service_ensure: 'running'
beid::service_name: 'pcscd'
```

#### Debian family

```yaml
beid::version: '2018.1'
beid::package_archive: "eid-archive_%{lookup('beid::version')}_all.deb"
beid::service_package: 'pcscd'
beid::browser_packages_manage: true
beid::firefox_extension_manage: true
beid::packages:
  - 'eid-viewer'
  - 'eid-mw'
beid::browser_packages:
  - 'icedtea-plugin'
  - 'default-jre'
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
```

## Limitations

This module has been tested on Debian 'stretch' and Fedora 27. CentOS 7 and distros based on Debian (e.g. Ubuntu 16.04) should work as well.

This module does ***not*** cover the installation of the smart card reader. More info can be found on the
[eiD FAQ](http://test.eid.belgium.be/faq/faq_nl.htm) from the Belgian governement and the [Debian Smartcards wiki](https://wiki.debian.org/Smartcards).


## Development

Since your module is awesome, other users will want to play with it. Let them know what the ground rules for contributing are.

## Release Notes/Contributors/Etc. **Optional**

If you aren't using changelog, put your release notes here (though you should consider using changelog). You can also add any additional sections you feel are necessary or important to include here. Please use the `## ` header.
