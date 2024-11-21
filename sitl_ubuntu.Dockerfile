# Ardupilot provides `install-prereqs-ubuntu.sh`, so let's use ubuntu
FROM ubuntu:22.04

# More releases: https://github.com/ArduPilot/ardupilot/releases
# Just use the latest one
ARG RELEASE_TAG=Tracker-4.5.7

## Ardupilot prereqs will hang if we don't disable interactive prompts (installing dependencies/apt and timezone configuration)
ENV TZ=UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
ENV DEBIAN_FRONTEND=noninteractive
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt update
RUN apt install -y git curl python3 sudo

# Switch to another user, to avoid Ardupilot prereqs script error: Please do not run this script as root;
ENV USER=docker
RUN adduser --disabled-password $USER
RUN adduser docker sudo
# Disable interactive password prompt for sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER $USER
ENV HOME=/home/$USER
WORKDIR $HOME

# Clone ardupilot
RUN git clone https://github.com/ArduPilot/ardupilot.git
ENV ARDUPILOT_PATH=/home/$USER/ardupilot
WORKDIR $ARDUPILOT_PATH
RUN git checkout ${RELEASE_TAG}
RUN git submodule update --init --recursive

RUN Tools/environment_install/install-prereqs-ubuntu.sh -y
# Add ~/.local/bin to PATH to allow mavproxy.py to be found
ENV PATH="$PATH:$HOME/.local/bin"

## Build ardupilot components
RUN ./waf distclean
RUN ./waf configure --board sitl
RUN ./waf copter
RUN ./waf rover 
RUN ./waf plane
RUN ./waf sub
