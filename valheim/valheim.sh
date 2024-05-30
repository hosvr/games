#!/bin/sh

servername="${SERVER_NAME}"
worldname="${WORLD_NAME}"
password="${WORLD_PASSWORD}"
preset="${PRESET:-normal}"
combat="${MOD_COMBAT:-veryeasy}"
death="${MOD_DEATH:-casual}"
resources="${MOD_RESOURCES:-most}"
raids="${MOD_RAIDS:-none}"
portals="${MOD_PORTALS:-casual}"
port="${SERVER_PORT:-2456}"

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
    -preset "${preset}" \
    -modifier combat "${combat}" \
    -modifier deathpenalty "${death}" \
    -modifier resources "${resources}" \
    -modifier raids "${raids}" \
    -modifier portals "${casual}" \
    -port "${port}" -nographics -batchmode -public 0

export LD_LIBRARY_PATH=$templdpath
