# PURPOSE:
# configures groups allowed to sudo
#
# HIERA DATA:
# profile::sudo::config:
#   purge:
#     Purge unmanaged files from config_dir
#   config_file_replace:
#     Replace config file with module config file
#
#  profile::sudo::group:
#     sudo line entry allowing specific group access
#
#
# HIERA EXAMPLE:
# profile::sudo::config:
#   purge: false
#   config_file_replace: false
#
# profile::sudo::group: 'active_directory_group'

# MODULE DEPENDENCIES:
# puppet module install saz-sudo
class profile_sudo {
  # lookup sudo config
  $config = hiera('profile::sudo::config')
  # lookup group allowed access to sudo
  $group  = hiera('profile::sudo::group')
  # validate lookup
  validate_hash($config)
  validate_string($group)

  # controll purging of sudo config
  class { 'sudo':
    purge               => $config[purge],
    config_file_replace => $config[config_file_replace],
  }

  # sudo::conf is a puppet type that enable sudo access
  # we'll use it to allow certain Active Directory groups access to sudo
  sudo::conf { $group:
    content  => "%${group} ALL=(ALL) NOPASSWD: ALL",
  }

  # create validation script
  validation_script { 'profile_sudo':
    profile_name    => 'profile_sudo',
    validation_data => $group,
  }
}
