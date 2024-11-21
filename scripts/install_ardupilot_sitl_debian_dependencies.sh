#!/bin/bash
set -euxo pipefail

## Install debian packages
BASE_PKGS="build-essential ccache g++ gawk git make wget valgrind screen"
SITL_PKGS="libtool libxml2-dev libxslt1-dev python3-dev python3-pip python3-setuptools python3-numpy python3-pyparsing python3-psutil"
apt-get install -y $BASE_PKGS $SITL_PKGS

## Install Python packages
# Create python env for SITL and load it. This is separate to the backend python environment.
python -m venv $VENV
source $VENV/bin/activate
# First build-time dependencies for the SITL python dependencies
python -m pip install --progress-bar off packaging setuptools wheel
# Install SITL python dependencies
python -m pip install --progress-bar off future lxml pymavlink pyserial MAVProxy pexpect geocoder empy==3.3.4 ptyprocess dronecan
