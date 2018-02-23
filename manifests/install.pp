class beid::install {

  case $facts['os']['name'] {
    /^(Debian|Ubuntu)/: { $beid::provider = 'dpkg' }
    'RedHat', 'CentOS':  { $beid::provider = 'yum' }
    'Fedora':  { $beid::provider = 'dnf' }
    default:  { fail("Module ${module_name} is not supported on ${::operatingsystem}") }
  }

  wget::fetch { $beid::package_archive:
    source      => "${beid::download_url}/${beid::package_archive}",
    destination => "/tmp/${beid::package_archive}",
    timeout     => 0,
    verbose     => false,
  }

  package { $beid::package_archive:
    ensure   => $beid::version,
    provider => $beid::provider,
    source   => "/tmp/${beid::package_archive}",
    require  => Wget::Fetch[$beid::package_archive],
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
