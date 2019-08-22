# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
class nrpe::base {
    include nrpe::settings
    include nrpe::service
    include config # for vars for templates

    $plugins_dir = $nrpe::settings::plugins_dir
    $nrpe_etcdir = $nrpe::settings::nrpe_etcdir

    case $::operatingsystem {
        # configure
        Darwin: {
            include packages::nrpe
            file {
                $nrpe_etcdir:
                    ensure  => directory,
                    owner   => $::users::root::username,
                    group   => $::users::root::group,
                    require => Class['packages::nrpe'];
                "${nrpe_etcdir}/nrpe.cfg":
                    content => template('nrpe/nrpe.cfg.erb'),
                    owner   => $::users::root::username,
                    group   => $::users::root::group,
                    require => Class['packages::nrpe'],
                    notify  => Class['nrpe::service'];
                "${nrpe_etcdir}/nrpe.d":
                    ensure  => directory,
                    owner   => $::users::root::username,
                    group   => $::users::root::group,
                    recurse => true,
                    purge   => true,
                    require => Class['packages::nrpe'],
                    notify  => Class['nrpe::service'];
            }
        }
        default: {
            fail("${::operatingsystem} not suported")
        }
    }
}
