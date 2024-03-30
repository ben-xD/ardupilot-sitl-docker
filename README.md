# Ardupilot SITL docker

With Ubuntu LTS 22.04 and X11/XQuartz display

## Setup

- Install [docker desktop](https://www.docker.com/products/docker-desktop/)
- Clone repo: `git clone https://github.com/ben-xD/ardupilot-sitl-docker`
- Run `cd ardupilot-sitl-docker`
- Build image: `docker-compose up -d`

## Usage

- **1 approach:** Enter container: run `docker exec -it ardupilot-sitl-docker-sitl-1 bash`
  - Once inside the container, start SITL: run `sim_vehicle.py -v ArduPlane --frame quadplane --map --console`
- Run any command from outside container: run `docker exec -it ardupilot-sitl-docker-sitl-1 $your_command`
- **1 command approach:** Run SITL command from outside container: `docker exec -it ardupilot-sitl-docker-sitl-1 /home/docker/ardupilot/Tools/autotest/sim_vehicle.py -v ArduPlane --frame quadplane --map --console`

## To get UI (MavProxy map and console) on macOS

![Screenshot of macOS running XQuartz showing 3 windows: ArduPlane SITL, MavProxy Map and MavProxy console](images/xquartz.png)

- Install [Xquartz](https://www.xquartz.org/)
- Configure it following https://stackoverflow.com/a/72593701/7365866
- Restart your computer
- Get your local IP, run `/usr/sbin/ipconfig getifaddr en0`
- In your terminal, run `xhost + 127.0.0.1`. You need to re-run this whenever XQuartz is restarted
- Start SITL: run `docker exec -it ardupilot-sitl-docker-sitl-1 /home/docker/ardupilot/Tools/autotest/sim_vehicle.py -v ArduPlane --frame quadplane --map --console`

## Avoiding running `zhost +` everytime

You could automatically run by adding the following to your `.zshrc`:
```bash
# See: 
# Allow docker containers to access X11/XQuartZ
xhost + 127.0.0.1 >/dev/null 2>&1
```

## Resources I used

- My experience writing Dockerfiles for a few years
- https://github.com/radarku/ardupilot-sitl-docker
- https://stackoverflow.com/questions/72586838/xquartz-cant-open-display-mac-os
- https://stackoverflow.com/questions/44429394/x11-forwarding-of-a-gui-app-running-in-docker

## Alternative approaches

You could consider adding ardupilot to the repo, and copying that in. That will allow you to make changes to Ardupilot and test them on a SITL conveniently.
