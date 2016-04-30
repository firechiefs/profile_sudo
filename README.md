## PURPOSE:

Configures groups allowed to sudo

## HIERA DATA:
```
  profile::sudo::config:
    purge: <Purge unmanaged files from config_dir>
    config_file_replace: <Replace config file with module config file>

  profile::sudo::group: <sudo line entry allowing specific group access note: do not include domain>
```
## HIERA EXAMPLE:
```
  profile::sudo::config:
    purge: false
    config_file_replace: false

  profile::sudo::group: 'active_directory_group'

```

## MODULE DEPENDENCIES:
```
puppet module install puppetlabs-dsc
```
## USAGE:

#### Puppetfile:
```
mod 'validation_script',
  :git => 'https://github.com/firechiefs/validation_script',
  :ref => '1.0.0'

mod 'profile_sudo',
  :git => 'https://github.com/firechiefs/profile_sudo',
  :ref => '1.0.0'
```
#### Manifests:
```
class role::*rolename* {
  include profile_sudo
}
```
