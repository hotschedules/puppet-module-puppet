# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker smartindent
#
# == Class: puppet::master::config::r10k
# ---
#
# Manages the Puppet Master r10k configuration
#
# === Parameters
# ---
#
# [*defaults*]
# - NOTE - Use puppet::master::r10k via Hiera to override any defaults
# - Type - Hash
# - Default
#   {
#     'enabled'     => true,
#     'usessh'      => true,
#     'autoupdate'  => true,
#     'timestamp'   => false,
#     'updatecmd'   => "r10k deploy environment ${::environment}",
#     'interval'    => '*/1',
#     'configfile'  => '/etc/r10k.yaml',
#     'cachedir'    => '/var/cache/r10k',
#     'basedir'     => '/etc/puppet/environments',
#   }
#
class puppet::master::config::r10k(

  $defaults = {
    'enabled'       => true,
    'usessh'        => true,
    'autoupdate'    => true,
    'timestamp'     => false,
    'timestampcmd'  => 'echo `date +\%Y-\%m-\%d-\%H:\%M:\%S` >> /var/log/r10k.log',
    'updatecmd'     => "r10k deploy environment ${::environment} -v -t >> /var/log/r10k.log 2>&1",
    'cronuser'      => 'puppet',
    'interval'      => '*/1',
    'configfile'    => '/etc/r10k.yaml',
    'cachedir'      => '/var/cache/r10k',
    'basedir'       => "/etc/puppet/environments",
  },

  $user     = $user,
  $group    = $group,
  $homedir  = '/var/lib/puppet',

) inherits puppet {

  # Require logrotate module
  Class['logrotate'] -> Class[$name]

  $mergedsettings = merge($defaults, $r10ksettings)

  $enabled      = $mergedsettings['enabled']
  $usessh       = $mergedsettings['usessh']
  $autoupdate   = $mergedsettings['autoupdate']
  $timestamp    = $mergedsettings['timestamp']
  $interval     = $mergedsettings['interval']
  $configfile   = $mergedsettings['configfile']
  $cachedir     = $mergedsettings['cachedir']
  $basedir      = $mergedsettings['basedir']
  $timestampcmd = $mergedsettings['timestampcmd']
  $updatecmd    = $mergedsettings['updatecmd']
  $cronuser     = $mergedsettings['cronuser']
  $remotes      = $mergedsettings['remotes']
  if has_key($mergedsettings,'packages') {
    $packages = $mergedsettings['packages']
  } else {
    $packages = {
      'r10k' => { 'provider' => 'gem', 'ensure' => 'present' },
      'SystemTimer' => { 'provider' => 'gem', 'ensure' => 'present' },
      'hiera-multiyaml' => { 'provider' => 'gem', 'ensure' => 'present' },
    }
  }

  validate_bool           ( $enabled      )
  validate_bool           ( $usessh       )
  validate_bool           ( $autoupdate   )
  validate_bool           ( $timestamp    )
  validate_string         ( $interval     )
  validate_absolute_path  ( $configfile   )
  validate_absolute_path  ( $cachedir     )
  validate_absolute_path  ( $basedir      )
  validate_string         ( $timestampcmd )
  validate_string         ( $updatecmd    )
  validate_string         ( $cronuser     )
  validate_hash           ( $remotes      )
  validate_hash           ( $packages     )

  define installer ($provider,$ensure) {
    ensure_resource(
      'clabs::install',
      $title,
      { 'provider' => $provider, 'ensure' => $ensure }
    )
  }

  if $enabled {

    create_resources(installer, $packages)

    clabs::dir { [
      $cachedir,
      $basedir,
    ]:
      owner     => $user,
      group     => $group,
      mode      => '0750',
    }

    clabs::template {
      $configfile:
        owner   => $user,
        group   => 'adm',
        mode    => '0440',  # secure (may contain passwords)
    }

    # puppet::master user
    user { $user:
      password  => '!!', # Disable password based login
      shell     => '/bin/bash',
    }

    # SSH keys
    if $usessh {
      validate_hash   ( $mergedsettings['ssh']            )
      validate_string ( $mergedsettings['ssh']['private'] )
      validate_string ( $mergedsettings['ssh']['public']  )

      $ssh_private  = $mergedsettings['ssh']['private']
      $ssh_public   = $mergedsettings['ssh']['public']

      clabs::dir {
        "${homedir}/.ssh":
          owner => $user,
          group => $group,
          mode  => '0700',
      }

      Clabs::Config {
        owner   => $user,
        group   => $group,
        require => Clabs::Dir["${homedir}/.ssh"]
      }

      ensure_resource('clabs::config', "${homedir}/.ssh/id_rsa", {
        'mode'    => '0400',
        'content' => $ssh_private,
      })

      ensure_resource('clabs::config', "${homedir}/.ssh/id_rsa.pub", {
        'mode'    => '0444',
        'content' => $ssh_public,
      })
    }
    
    # r10k time stamping
    cron { 'puppetmaster-r10k-timestamp':
      ensure  => $timestamp ? {
        true    => 'present',
        default => 'absent',
      },
      command => $timestampcmd,
      user    => $user,
      minute  => $interval,
    }

    # r10k Automatic code updates
    cron { 'puppetmaster-r10k-autoupdate':
      ensure  => $autoupdate ? {
        true    => 'present',
        default => 'absent',
      },
      command => $updatecmd,
      user    => $cronuser,
      minute  => $interval,
      require => $timestamp ? {
        true    => [ Cron['r10k-timestamp'], File['/usr/local/bin/run-r10k'], ],
        default => undef,
      },
    }

    if $timestamp {
      file { '/var/log/r10k.log':
        ensure  => 'present',
        owner   => $user,
        group   => $group,
        mode    => '0664',
      }
      logrotate::rule { 'puppetmaster-r10k-timestamp':
        ensure        => 'present',
        path          => '/var/log/r10k.log',
        missingok     => true,
        ifempty       => false,
        rotate        => 4,
        rotate_every  => 'week',
        compress      => true,
        create        => true,
        create_mode   => '0664',
        create_owner  => $user,
        create_group  => $group,
      }
    }
    if $autoupdate {
      file { '/usr/local/bin/run-r10k':
        ensure => 'present',
        source => 'puppet:///modules/puppet/run-r10k',
        owner  => root,
        group  => root,
        mode   => '0755'
      }
    }
  }
}

