# This class handles the beid service. Avoid modifying private classes.
class beid::service {

  if $beid::service_manage == true {
    service { 'beid':
      ensure     => $beid::service_ensure,
      enable     => $beid::service_enable,
      name       => $beid::service_name,
      hasstatus  => true,
      hasrestart => true,
    }
  }

}
