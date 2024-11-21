# An image with debian and uv/python, and uses a simplified script to install dependencies on Debian, install of the 500 line script from Ardupilot for installing into Debian.
FROM python:3.11-bookworm
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# More releases: https://github.com/ArduPilot/ardupilot/releases
# Just use the latest one
ARG RELEASE_TAG=Tracker-4.5.7

ENV TZ=UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
ENV DEBIAN_FRONTEND=noninteractive
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt update
RUN apt install -y curl vim

ENV VENV=$HOME/venv-ardupilot
COPY ./scripts/install_ardupilot_sitl_debian_dependencies.sh .
RUN ./install_ardupilot_sitl_debian_dependencies.sh
# Add ~/.local/bin to PATH to allow mavproxy.py to be found after it's installed
ENV PATH="$PATH:$HOME/.local/bin"
# Configure the venv binaries (python, pip) to be the first in the PATH, 
# so that waf (and anything else ) will use it instead of default system pthon.
ENV PATH="$VENV/bin:$PATH"

# Switch to another user to be consistent with the Ubuntu setup
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

# Build Ardupilot
RUN ./waf distclean
RUN ./waf configure --board sitl
RUN ./waf copter
RUN ./waf rover 
RUN ./waf plane
RUN ./waf sub
