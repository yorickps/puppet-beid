# Class: beid
# 
# @summary Puppet module to install Belgian eID software
# 
# Parameters:
# @param download_url Download url for Belgian eID software
# @param browser_packages Extra browser packages for Firefox
# @param browser_packages_manage Whether or not to manage browser packages. Default true
# @param packages Packages to install (eid-viewer and eid-middleware)
# @param package_archive Full name of the package archive to download from download_url
# @param package_archive_name Short name of the package archive
# @param package_ensure Install the package. Default true
# @param package_manage Manage the eid package. Default true
# @param service_enable Enable the card reader service (pcscd). Default true
# @param service_ensure Run the card reader service (pcscd). Default running
# @param service_name Name of the card reader service
# @param service_manage Whether or not to manage the card reader service. Default true
# @param service_package Name of the service package
# @param version Version to install of the eid package from the Belgian governement
# @param firefox_extension Firefox extension name
# @param firefox_extension_manage Whether or not to manage the Firefox extension. Default true
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
