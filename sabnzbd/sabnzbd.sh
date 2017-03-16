#!/bin/bash
set -e

#
# Display settings on standard out.
#

USER="sabnzbd"

echo "SABnzbd settings"
echo "================"
echo
echo "  User:       ${USER}"
echo "  UID:        ${SABNZBD_UID:=666}"
echo "  GID:        ${SABNZBD_GID:=666}"
echo
echo "  Config:     ${CONFIG:=/config/sabnzbd.ini}"
echo

#
# Change UID / GID of SABnzbd user.
#

printf "Updating UID / GID... "
[[ $(id -u ${USER}) == ${SABNZBD_UID} ]] || usermod  -o -u ${SABNZBD_UID} ${USER}
[[ $(id -g ${USER}) == ${SABNZBD_GID} ]] || groupmod -o -g ${SABNZBD_GID} ${USER}
echo "[DONE]"


#
# Mount
#

printf "Mounting ${NFS_HOST}:${NFS_PATH} on ${DATA_DIR}"
mount -o nfsvers=4 ${NFS_HOST}:${NFS_PATH} ${DATA_DIR}
printf "[DONE]"

#
# Set directory permissions.
#

printf "Set permissions..."
printf "touching ${CONFIG}"
touch ${CONFIG}
printf "chown -R ${USER}: /sabnzbd"
chown -R ${USER}: /sabnzbd
function check_dir {
  [ "$(stat -c '%u %g' $1)" == "${SABNZBD_UID} ${SABNZBD_GID}" ] || chown ${USER}: $1
}

mount -o nfsvers=4 ${NFS_HOST}:${NFS_PATH} ${DATA_DIR}

#check_dir ${DATA_DIR}
#check_dir /media
check_dir $(dirname ${CONFIG})
echo "[DONE]"

#
# Because SABnzbd runs in a container we've to make sure we've a proper
# listener on 0.0.0.0. We also have to deal with the port which by default is
# 8080 but can be changed by the user.
#

printf "Get listener port... "
PORT=$(sed -n '/^port *=/{s/port *= *//p;q}' ${CONFIG})
LISTENER="-s 0.0.0.0:${PORT:=8080}"
echo "[${PORT}]"

#
# Finally, start SABnzbd.
#

echo "Starting SABnzbd... with ./SABnzbd.py -b 0 -f ${CONFIG} ${LISTENER} ${CMD_PARAMS}"
exec su -pc "./SABnzbd.py -b 0 -f ${CONFIG} ${LISTENER} ${CMD_PARAMS}" ${USER}
