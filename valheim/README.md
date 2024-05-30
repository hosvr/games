# games/valheim

files to run a valheim dedicated server

https://valheim.fandom.com/wiki/Dedicated_servers#Manual_Setup

`valheim.sh` script must be in the same folder as the server installation

update the following env vars in the docker compose file
* WORLD_NAME
* WORLD_PASSWORD

custom configuration can be done in the valheim.sh script
if you user other ports than the default (2456) then make sure to update it in the dockerfile
