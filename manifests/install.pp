# This class handles beid package install
class beid::install {
  archive { $beid::package_archive:
    ensure  => present,
    source  => "${beid::download_url}/${beid::package_archive}",
    path    => "/tmp/${beid::package_archive}",
    cleanup => false,
  }

  if $facts['os']['family'] == 'Debian' {

    include ::apt

    package { $beid::package_archive_name:
      ensure  => latest,
      source  => "/tmp/${beid::package_archive}",
      require => Archive[$beid::package_archive],
      notify  => Exec['apt_update'],
    }
  }

  if $facts['os']['family'] == 'RedHat' {
    package { $beid::package_archive_name:
      ensure  => latest,
      name    => $beid::package_archive,
      source  => "/tmp/${beid::package_archive}",
      require => Archive[$beid::package_archive],
    }
  }

  if $beid::package_manage {
    ensure_packages($beid::packages, { ensure => $beid::package_ensure })
  }

  if ($facts['os']['family'] == 'Debian' and $beid::browser_packages_manage) {
    ensure_packages($beid::browser_packages, { ensure => latest })
  }

  if ($facts['os']['family'] == 'Debian' and $beid::firefox_extension_manage) {
    package { $beid::firefox_extension:
      ensure  => latest,
      require => Package[$beid::package_archive_name],
    }
  }

  if $beid::service_manage {
    package { $beid::service_package:
      ensure  => latest,
    }
  }
}
