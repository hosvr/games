# games/valheim

files to run a valheim dedicated server

https://valheim.fandom.com/wiki/Dedicated_servers#Manual_Setup

`valheim.sh` script must be in the same folder as the server installation

update the following env vars in the docker compose file
* WORLD_NAME
* WORLD_PASSWORD

custom configuration can be done in the valheim.sh script
if you user other ports than the default (2456) then make sure to update it in the dockerfile

## modifiers

modifiers can be placed by entering environment variables in the docker-compose file

* `PRESET`: normal, casual, easy, hard, hardcore, immersive, hammer
* `MOD_COMBAT`: veryeasy, easy, hard, veryhard
* `MOD_DEATH`: casual, veryeasy, easy, hard, hardcore
* `MOD_RESOURCES`: muchless, less, more, muchmore, most
* `MOD_RAIDS`: none, muchless, less, more, muchmore
* `MOD_PORTALS`: casual, hard, veryhard

any environment variable not set will default to the easiest one
