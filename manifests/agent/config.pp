# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker smartindent
#
# == Class: puppet::agent::config {
#
# Sets default puppet parameters
#
# PRIVATE CLASS: do not call directly
#
class puppet::agent::config inherits puppet {

  create_resources(puppetagentconf, { 'params' => {'main' => $x_main, 'agent' => $x_agent }} )

}

