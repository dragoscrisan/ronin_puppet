# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

class win_packages::jq {

    if $::operatingsystem == 'Windows' {
        file { "${facts['custom_win_system32']}\\jq.exe":
            ensure => present,
            source => 'https://s3.amazonaws.com/windows-opencloudconfig-packages/RoninPackages/jq-win64.exe',
        }
    } else {
        fail("${module_name} does not support ${::operatingsystem}")
    }
}
