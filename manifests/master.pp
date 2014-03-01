# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker smartindent
#
# Puppet
#

class puppet::master (
  $enabled,
  $svc,

  # r10k
  $r10kremote,
  $r10kcachedir,
  $r10kbasedir,
) {

  # Master depends on puppet client configuration
  Class['puppet'] -> Class[$name]

  clabs::module::init { $name: }

}

