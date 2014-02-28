# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker smartindent
#
# Puppet
#

class puppet (
  $enabled,
  $svc,
  $config,
  $master,
  $dns_alt_names,
  $env = $::environment,
) {

  clabs::module::init { $name: }

}
