FROM debian:12
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

ARG ARDUPILOT_VERSION
RUN apt update

# Configure the venv binaries (python, pip) to be the first in the PATH, 
# so that waf (and anything else ) will use it instead of default system pthon.
ENV HOME=/root
ENV VENV=$HOME/venv-ardupilot
RUN uv venv --python 3.13 --no-project $VENV
ENV PATH="$VENV/bin:$PATH"
# Add ~/.local/bin to PATH to allow mavproxy.py to be found after it's installed
ENV PATH="$PATH:$HOME/.local/bin"

COPY ./scripts/install_ardupilot_sitl_apt_dependencies.sh .
RUN ./install_ardupilot_sitl_apt_dependencies.sh

RUN git clone --branch ${ARDUPILOT_VERSION} --depth 1 --recurse-submodules https://github.com/ArduPilot/ardupilot.git $HOME/ardupilot
WORKDIR $HOME/ardupilot

# Build Ardupilot
RUN ./waf distclean
RUN ./waf configure --board sitl
RUN ./waf copter
RUN ./waf rover 
RUN ./waf plane
RUN ./waf sub
