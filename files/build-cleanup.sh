#!/bin/bash

# Headers are only needed while compiling; pin the runtime libraries PHP and its extensions link against before purging them
find /usr/local -type f \( -executable -o -name '*.so' \) -exec ldd '{}' ';' 2>/dev/null \
    | awk '/=>/ { so = $(NF-1); if (index(so, "/usr/local/") == 1) { next }; gsub("^/(usr/)?", "", so); printf "*%s\n", so }' \
    | sort -u \
    | xargs -r dpkg-query --search \
    | cut -d: -f1 \
    | sort -u \
    | xargs -r apt-mark manual

apt-get remove -y autoconf automake libtool make cmake ninja-build pkg-config build-essential g++ gcc;
apt-get purge -y $(dpkg-query -W -f='${db:Status-Abbrev} ${Package}\n' '*-dev' libc6-dev linux-libc-dev | awk '$1 == "ii" { print $2 }')
apt-get clean
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/* ~/.composer || true
apt-get autoremove -y
sync
