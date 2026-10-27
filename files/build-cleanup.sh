#!/bin/bash

# The intl extension links against the ICU runtime, which is only pulled in by libicu-dev; keep it when that is removed
apt-mark manual $(dpkg-query -W -f='${Package}\n' 'libicu[0-9]*')
apt-get remove -y autoconf automake libtool make cmake ninja-build pkg-config build-essential g++ gcc libicu-dev;
apt-get clean
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/* ~/.composer || true
apt-get autoremove -y
sync

