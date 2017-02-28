# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Class: puppet::params::main::default {
#
# Sets default puppet parameters
#
# PRIVATE CLASS: do not call directly
#
  disable_warnings           => 'deprecations',
  logdir                     => '/var/log/puppet',
  rundir                     => '/var/run/puppet',
  ssldir                     => '$vardir/ssl',
