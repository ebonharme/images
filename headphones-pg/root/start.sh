#!/bin/sh

[ -d ${DATA_DIR} ] || mkdir -p ${DATA_DIR}
[ -d ${MUSIC_DIR}] || mkdir -p ${MUSIC_DIR}

echo "Mounting ${NFS_HOST}:${NFS_DATA_PATH} on ${DATA_DIR}"
mount -o nfsvers=4 ${NFS_HOST}:${NFS_DATA_PATH} ${DATA_DIR}

echo "Mounting ${NFS_HOST}:${NFS_MUSIC_PATH} on ${MUSIC_DIR}"
mount -o nfsvers=4 ${NFS_HOST}:${NFS_MUSIC_PATH} ${MUSIC_DIR}

/init
