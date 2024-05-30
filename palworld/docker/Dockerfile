FROM ubuntu:22.04

# Insert Steam prompt answers
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN echo steam steam/question select "I AGREE" | debconf-set-selections \
 && echo steam steam/license note '' | debconf-set-selections

ARG DEBIAN_FRONTEND=noninteractive
RUN dpkg --add-architecture i386 \
	&& apt-get update -y \
	&& apt-get install -y --no-install-recommends ca-certificates locales steamcmd \
	&& rm -rf /var/lib/apt/lists/* \
	&& useradd -u 1000 steam

USER steam
WORKDIR /home/steam

# Install SteamCMD
RUN /usr/games/steamcmd \
	+login anonymous \
	+app_update 2394010 validate \
	+quit \
	&& mkdir -p ~/.steam/sdk64/ \
	&& /usr/games/steamcmd +login anonymous +app_update 1007 +quit \
	&& cp ~/Steam/steamapps/common/Steamworks\ SDK\ Redist/linux64/steamclient.so ~/.steam/sdk64/

ENTRYPOINT ["/bin/bash","-c","/home/steam/Steam/steamapps/common/PalServer/PalServer.sh","-useperfthreads","-NoAsyncLoadingThread","-UseMultithreadForDS"]
