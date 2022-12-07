# Class: beid
# 
# @summary Puppet module to install Belgian eID software
# 
# Parameters:
# @param download_url
# @param browser_packages
# @param browser_packages_manage
# @param packages
# @param service_enable
# @param service_ensure
# @param package_archive
# @param package_archive_name
# @param package_ensure
# @param package_manage
# @param service_name
# @param service_manage
# @param service_package
# @param version
class beid (
  Stdlib::HTTPSUrl $download_url,
  Optional[Array[String]] $browser_packages,
  Optional[Boolean] $browser_packages_manage,
  Optional[String] $firefox_extension,
  Optional[Boolean] $firefox_extension_manage,
  Array[String] $packages,
  Boolean $service_enable,
  Enum['running', 'stopped'] $service_ensure,
  String $package_archive,
  Optional[String] $package_archive_name,
  String $package_ensure,
  Boolean $package_manage,
  String $service_name,
  Boolean $service_manage,
  String $service_package,
  String $version,
) {
  contain beid::install
  contain beid::service

  Class['beid::install']
  ~> Class['beid::service']
}
