#!/bin/sh
. /static/common

# - - sanity checks - - #
if mountpoint /data >/dev/null 2>&1; then
    if [ ! -f "/data/extra.conf" ]; then
        perr "/data is bind mounted but extra.conf does not exist, exiting."
    fi
fi

# - - hand over - - #
pinfo "setting permissions for dirs under /data"
find /data -type d -exec chmod 0750 {} ';'
evalret

pinfo "setting permissions for files under /data"
find /data -type f -exec chmod 0640 {} ';'
evalret

pinfo "setting ownership of /data"
chown -Rh named:named /data
evalret

pinfo "starting named"
exec named -u named -g
