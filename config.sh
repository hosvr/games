#!/bin/bash

dnf update && dnf upgrade
dnf install -y git docker

# docker-compose
curl \
    -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) \
    -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

useradd -m -G docker -u 2000 -s /bin/bash games
cp -r /home/ec2-user/.ssh /home/games
chown -R games:games /home/games

git clone https://github.com/hosvr/games.git /repo
chown -R games:games /repo

systemctl enable docker
systemctl start docker
