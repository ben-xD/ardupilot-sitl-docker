# Ardupilot SITL docker

Run Ardupilot SITL in Docker in Ubuntu LTS 22.04, with SITL and MAVProxy UI using X11/XQuartz display

![Screenshot of macOS running XQuartz showing 3 windows: ArduPlane SITL, MavProxy Map and MavProxy console](images/xquartz.png)

## Quick usage

*The quick approach skips setting up UIs and won't use docker-compose, but starts the SITL in Ubuntu (6GB) in **one** command, as long as Docker Desktop is installed.*
```bash
docker run -it orthuk/ardupilot-sitl /home/docker/ardupilot/Tools/autotest/sim_vehicle.py -v ArduPlane --frame quadplane --map --console
```

For the same command, but to use Debian (5GB, 1GB less than Ubuntu), run:
```bash
docker run -it orthuk/ardupilot-sitl-debian /home/docker/ardupilot/Tools/autotest/sim_vehicle.py -v ArduPlane --frame quadplane --map --console
```

## Setup

- Install [docker desktop](https://www.docker.com/products/docker-desktop/)
- Clone repo: `git clone https://github.com/ben-xD/ardupilot-sitl-docker`
- Run `cd ardupilot-sitl-docker`
- Either:
  - Download and run the [images I publish](https://hub.docker.com/r/orthuk/ardupilot-sitl): `docker-compose up -d remote`
  - Build a local image: `docker-compose up -d local_debian` (or local_ubuntu)

## Usage

- Depending on if you're using locally buit or remote image, use `sitl-remote-1` or `sitl-local-1` as the container name

- **1 command approach:** Run SITL command from outside container: `docker exec -it sitl-local-1 /home/docker/ardupilot/Tools/autotest/sim_vehicle.py -v ArduPlane --frame quadplane --map --console`
  - Run any command from outside container: run `docker exec -it sitl-local-1 $your_command`
- **Enter container approach:** Enter container: run `docker exec -it sitl-local-1 bash`
  - Once inside the container, start SITL: run `sim_vehicle.py -v ArduPlane --frame quadplane --map --console`

### More specific usage examples

Pro tip: Read the help pages for sim_vehicle.py (`sim-vehicle.help.md`) and MAVProxy (`MAVProxy.help.md`).

- Run alongside other GCSs by configuring MAVProxy to output to a port that your GCS listens on: run `docker exec -it sitl-local-1 /home/docker/ardupilot/Tools/autotest/sim_vehicle.py -v ArduPlane --frame quadplane --map --console -w --mavproxy-args="--out udp:host.docker.internal:14550 --state-basedir=/tmp/mavlink-sitl"`
  - Just install and start [QGroundControl](http://qgroundcontrol.com/). QGroundControl will automatically detect UDP mavlink on 14550.
  - You can even connect your SITL to [Android mission planner](https://ardupilot.org/planner/docs/mission-planner-installation.html#mission-planner-on-android). Find out your android's IP address, and add `--out :udp:$ANDROID_IP_ADDRESS:14550` and launch Mission Planner.
- Run without MAVProxy: `docker exec -it sitl-remote-1 /home/docker/ardupilot/build/sitl/bin/arduplane -S --model quadplane --speedup 1 --sysid 1 --slave 0 --defaults Tools/autotest/default_params/quadplane.parm --sim-address=host.docker.internal -I0`, then start your GCS.

![QGroundControl on macOS and Mission Planner on Android](./images/GCSs.png)

## To setup UI (MavProxy map, console and ArduPlane SITL) on macOS

- Install [Xquartz](https://www.xquartz.org/)
- Open Xquarts, go into preferences, Security, and enable  "Allow connections from network clients" (credits to https://stackoverflow.com/a/72593701/7365866)
![XQuartz settings page](https://i.stack.imgur.com/NYWcM.png)

- Restart your computer
- In your terminal, run `xhost + 127.0.0.1`. You need to re-run this whenever XQuartz is restarted
- Start SITL: run `docker exec -it sitl-local-1 /home/docker/ardupilot/Tools/autotest/sim_vehicle.py -v ArduPlane --frame quadplane --map --console`

## Avoiding running `xhost +` everytime

You could automatically run by adding the following to your `.zshrc`:
```bash
# Ardupilot SITL Docker, see https://github.com/ben-xd/ardupilot-sitl-docker
# Allow docker containers to access X11/XQuartz
xhost + 127.0.0.1 >/dev/null 2>&1
```

## Resources I used

- My experience writing Dockerfiles for a few years
- https://github.com/radarku/ardupilot-sitl-docker
  - I contributed some changes to it a few years ago (https://github.com/radarku/ardupilot-sitl-docker/commit/ee44adc4f6d57bbddaf911c102cb9ec40e79c683 and https://github.com/radarku/ardupilot-sitl-docker/commit/48cae9d88d8894dcbb6b805c19468a4bc1835877)
- https://ardupilot.org/dev/docs/building-setup-linux.html#building-setup-linux
- https://stackoverflow.com/questions/72586838/xquartz-cant-open-display-mac-os
- https://stackoverflow.com/questions/44429394/x11-forwarding-of-a-gui-app-running-in-docker
- Help pages are saved  to `sim_vehicle.README.md` and `MAVProxy.README.md` for convenience using:
  - `docker exec -it sitl-local-1 /home/docker/ardupilot/Tools/autotest/sim_vehicle.py --help > sim_vehicle.README.md`
  - `docker exec -it sitl-local-1 mavproxy.py --help > MAVProxy.README.md`

## Alternative approaches

You could consider adding ardupilot to the repo, and copying that in. That will allow you to make changes to Ardupilot and test them on a SITL conveniently.

## Maintainance:

- login: `docker login`
- build, e.g. `docker-compose up -d local_debian` (or local_ubuntu)
- publish: `docker push orthuk/ardupilot-sitl-debian:0.1.0` or `docker push orthuk/ardupilot-sitl:0.1.0`