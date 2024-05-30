#!/bin/bash

dnf update && dnf upgrade
dnf install -y git docker

# docker-compose
curl \
    -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) \
    -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

systemctl enable docker
systemctl start docker

usermod -a -G docker ec2-user

git clone https://github.com/hosvr/games.git /games
chown -R ec2-user:ec2-user /games
