# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

class win_nxlog (
    $nxlog_dir = undef,
    $location = undef
){

    if $::operatingsystem == 'Windows' {
        include win_nxlog::install
        include win_nxlog::configuration
        include win_nxlog::fw_exception
        include win_nxlog::service
        if ($location == 'aws') {
            include win_nxlog::pem_file
        }
    } else {
        fail("${module_name} does not support ${::operatingsystem}")
    }
}

# Bug list
# https://bugzilla.mozilla.org/show_bug.cgi?id=1520947
