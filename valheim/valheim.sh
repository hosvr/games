#!/bin/sh

servername="${SERVER_NAME}"
worldname="${WORLD_NAME}"
password="${WORLD_PASSWORD}"

export templdpath=$LD_LIBRARY_PATH  
export LD_LIBRARY_PATH=./linux64:$LD_LIBRARY_PATH  
export SteamAppID=892970

echo "Updating steam files"
steamcmd \
    +@sSteamCmdForcePlatformType linux \
    +force_install_dir /home/steam \
    +login anonymous \
    +app_update 896660 -beta none validate \
    +quit

echo "Starting server PRESS CTRL-C to exit"  
./valheim_server.x86_64 \
    -name "${servername}" \
    -world "${worldname}" \
    -password "${password}" \
    -savedir "./data" \
    -preset hardcore \
    -modifier portals casual \
    -modifier resources muchmore \
    -modifier deathpenalty easy \
    -port 2456 -nographics -batchmode -public 0

export LD_LIBRARY_PATH=$templdpath
