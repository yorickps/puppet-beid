# beid
#
# Main class, includes all other classes.
class beid (
  $download_url,
  Array[String]$browser_packages,
  Array[String]$packages,
  Boolean $service_enable,
  Enum['running', 'stopped'] $service_ensure,
  String $package_archive,
  String $package_archive_name,
  String $package_ensure,
  String $service_name,
  String $service_package,
  String $version,
){

  contain beid::install
  contain beid::service

  Class['::beid::install']
  -> Class['::beid::service']
}
