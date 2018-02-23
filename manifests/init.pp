# beid
#
# Main class, includes all other classes.
class beid (
  Boolean $service_enable,
  Enum['running', 'stopped'] $service_ensure,
  $download_url,
  String $package_archive,
  String $service_name,
  String $service_package,
  String $version,
){

  contain beid::install
  contain beid::service

  Class['::beid::install']
  -> Class['::beid::service']
}
