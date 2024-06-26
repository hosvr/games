# games

repo for different game server configuration

# server config

there are various methods in here for initial server setup

1. `aws` 
    * setup intended for a static ec2 instance
    * `terraform`: `main.tf`
    * `cloud-init`: `config.sh`
    * uses terraform workspace for state management
2. `bare`
    * setup intended for a bare metal instance or home installation
