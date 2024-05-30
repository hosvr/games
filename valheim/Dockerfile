FROM ubuntu:24.04

### steamcmd 
### https://github.com/steamcmd/docker/blob/master/dockerfiles/ubuntu-24/Dockerfile
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN echo steam steam/question select "I AGREE" | debconf-set-selections \
 && echo steam steam/license note '' | debconf-set-selections

# Update the repository and install SteamCMD
ARG DEBIAN_FRONTEND=noninteractive
RUN dpkg --add-architecture i386 \
	&& apt-get update -y \
	&& apt-get upgrade -y \
	&& apt-get install -y --no-install-recommends ca-certificates locales steamcmd \
 		libpulse-dev libatomic1 libc6 libc6-dev libpulse0 \
	&& rm -rf /var/lib/apt/lists/* \
	&& ln -s /usr/games/steamcmd /usr/bin/steamcmd \
	&& useradd -m -u 2000 -s /bin/bash steam

USER steam
WORKDIR /home/steam

RUN steamcmd \
		+@sSteamCmdForcePlatformType linux \
		+force_install_dir /home/steam \
		+login anonymous \
		+app_update 896660 -beta none validate \
		+quit \
	&& ln -s $HOME/.local/share/Steam/steamcmd/linux32 $HOME/.steam/sdk32 \
	&& ln -s $HOME/.local/share/Steam/steamcmd/linux64 $HOME/.steam/sdk64 \
	&& ln -s $HOME/.steam/sdk32/steamclient.so $HOME/.steam/sdk32/steamservice.so \
	&& mkdir /home/steam/data

COPY --chown=steam:steam --chmod=0755 valheim.sh /home/steam/valheim.sh
COPY --chown=steam:steam adminlist.txt /home/steam/data/adminlist.txt

EXPOSE 2456/udp 2457/udp 2458/udp
EXPOSE 2456/tcp 2457/tcp 2458/tcp

ENTRYPOINT ["/bin/bash","-c","/home/steam/valheim.sh"]
