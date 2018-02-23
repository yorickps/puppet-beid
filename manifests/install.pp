# This class handles beid package install
class beid::install {

  case $facts['os']['name'] {
    /^(Debian|Ubuntu)/: { $provider = 'dpkg' }
    'RedHat', 'CentOS':  { $provider = 'yum' }
    'Fedora':  { $provider = 'dnf' }
    default:  { fail("Module ${::module_name} is not supported on ${::operatingsystem}") }
  }

  archive { $beid::package_archive:
    ensure  => present,
    source  => "${beid::download_url}/${beid::package_archive}",
    path    => "/tmp/${beid::package_archive}",
    cleanup => false,
  }

  package { $beid::package_archive:
    ensure   => latest,
    provider => $provider,
    source   => "/tmp/${beid::package_archive}",
    require  => Archive[$beid::package_archive],
  }

  if $beid::package_manage {

    package { $beid::packages:
      ensure  => $beid::package_ensure,
      require =>  Package[$beid::package_archive]
    }
  }

  if ($facts['os']['family'] == 'Debian' and $beid::browser_packages_manage){

    package { $beid::browser_packages:
      ensure  => latest,
      require => Package[$beid::package_archive]
    }
  }

  if ($facts['os']['family'] == 'Debian' and $beid::firefox_extension_manage){

    package { $beid::firefox_extension:
      ensure  => latest,
      require => Package[$beid::package_archive]
    }
  }

  if $beid::manage_service {

    package { $beid::service_package:
      ensure  => latest,
    }
  }


}
