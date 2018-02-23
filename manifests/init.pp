class beid (
  Boolean $service_enable,
  Enum['running', 'stopped'] $service_ensure,
  Stdlib::Httpurl $download_url,
  String $package_archive,
  String $service_name,
  String $service_package,
  String $version,
){

  contain beid::install
  contain beid::config
  contain beid::service

  Class['::beid::install']
  -> Class['::beid::config']
  ~> Class['::beid::service']
}
