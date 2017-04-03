# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker smartindent
#
# == Class: puppet::master::config {
#
# Sets default puppet parameters
#
# PRIVATE CLASS: do not call directly
#
class puppet::master::config inherits puppet {
  # Create Puppet agent configuration
  create_resources(puppetmasterconf, $x_conf_hash)
}
