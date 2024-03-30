Usage: sim_vehicle.py

Options:
  -h, --help            show this help message and exit
  -v VEHICLE, --vehicle=VEHICLE
                        vehicle type (ArduCopter|Helicopter|Blimp|ArduPlane|Ro
                        ver|ArduSub|AntennaTracker|sitl_periph_gps)
  -f FRAME, --frame=FRAME
                        set vehicle frame type
                        ArduCopter: +|Callisto|IrisRos|X|airsim-
                            copter|bfx|calibration|coaxcopter|cwx|deca|deca-
                            cwx|djix|dodeca-hexa|gazebo-iris|heli|heli-
                            blade360|heli-dual|hexa|hexa-cwx|hexa-
                            dji|octa|octa-cwx|octa-dji|octa-quad|octa-quad-
                            cwx|quad|scrimmage-copter|singlecopter|tri|y6
                        Helicopter: heli|heli-blade360|heli-dual
                        Blimp: Blimp
                        ArduPlane: CRRCSim|calibration|firefly|gazebo-
                            zephyr|jsbsim|last_letter|plane|plane-3d|plane-
                            dspoilers|plane-elevon|plane-ice|plane-jet|plane-
                            soaring|plane-tailsitter|plane-
                            vtail|quadplane|quadplane-cl84|quadplane-
                            copter_tailsitter|quadplane-ice|quadplane-
                            tilthvec|quadplane-tilttri|quadplane-
                            tilttrivec|quadplane-tri|scrimmage-plane
                        Rover: airsim-rover|balancebot|calibration|gazebo-
                            rover|motorboat|rover|rover-skid|rover-
                            vectored|sailboat|sailboat-motor
                        ArduSub: gazebo-bluerov2|vectored|vectored_6dof
                        AntennaTracker: tracker
                        sitl_periph_gps: gps
  --vehicle-binary=VEHICLE_BINARY
                        vehicle binary path
  -C, --sim_vehicle_sh_compatible
                        be compatible with the way sim_vehicle.sh works; make
                        this the first option

  Build options:
    -N, --no-rebuild    don't rebuild before starting ardupilot
    -D, --debug         build with debugging
    -c, --clean         do a make clean before building
    -j JOBS, --jobs=JOBS
                        number of processors to use during build (default for
                        waf : number of processor, for make : 1)
    -b BUILD_TARGET, --build-target=BUILD_TARGET
                        override SITL build target
    -s BUILD_SYSTEM, --build-system=BUILD_SYSTEM
                        build system to use
    --enable-math-check-indexes
                        enable checking of math indexes
    --sitl-32bit        compile sitl using 32-bit
    --configure-define=DEFINE
                        create a preprocessor define
    --rebuild-on-failure
                        if build fails, do not clean and rebuild
    --waf-configure-arg=WAF_CONFIGURE_ARGS
                        extra arguments to pass to waf in configure step
    --waf-build-arg=WAF_BUILD_ARGS
                        extra arguments to pass to waf in its build step
    --coverage          use coverage build
    --ubsan             compile sitl with undefined behaviour sanitiser
    --ubsan-abort       compile sitl with undefined behaviour sanitiser and
                        abort on error
    --num-aux-imus=NUM_AUX_IMUS
                        number of auxiliary IMUs to simulate

  Simulation options:
    -I INSTANCE, --instance=INSTANCE
                        instance of simulator
    -n COUNT, --count=COUNT
                        vehicle count; if this is specified, -I is used as a
                        base-value
    -i INSTANCES, --instances=INSTANCES
                        a space delimited list of instances to spawn; if
                        specified, overrides -I and -n.
    -V, --valgrind      enable valgrind for memory access checking (slow!)
    --callgrind         enable valgrind for performance analysis (slow!!)
    -T, --tracker       start an antenna tracker instance
    --enable-onvif      enable onvif camera control sim using AntennaTracker
    --can-gps           start a DroneCAN GPS instance (use
                        Tools/scripts/CAN/can_sitl_nodev.sh first)
    -A SITL_INSTANCE_ARGS, --sitl-instance-args=SITL_INSTANCE_ARGS
                        pass arguments to SITL instance
    -G, --gdb           use gdb for debugging ardupilot
    -g, --gdb-stopped   use gdb for debugging ardupilot (no auto-start)
    --lldb              use lldb for debugging ardupilot
    --lldb-stopped      use ldb for debugging ardupilot (no auto-start)
    -d DELAY_START, --delay-start=DELAY_START
                        delay start of mavproxy by this number of seconds
    -B BREAKPOINT, --breakpoint=BREAKPOINT
                        add a breakpoint at given location in debugger
    --disable-breakpoints
                        disable all breakpoints before starting
    -M, --mavlink-gimbal
                        enable MAVLink gimbal
    -L LOCATION, --location=LOCATION
                        use start location from Tools/autotest/locations.txt
    -l CUSTOM_LOCATION, --custom-location=CUSTOM_LOCATION
                        set custom start location (lat,lon,alt,heading)
    -S SPEEDUP, --speedup=SPEEDUP
                        set simulation speedup (1 for wall clock time)
    -t TRACKER_LOCATION, --tracker-location=TRACKER_LOCATION
                        set antenna tracker start location
    -w, --wipe-eeprom   wipe EEPROM and reload parameters
    -m MAVPROXY_ARGS, --mavproxy-args=MAVPROXY_ARGS
                        additional arguments to pass to mavproxy.py
    --scrimmage-args=SCRIMMAGE_ARGS
                        arguments used to populate SCRIMMAGE mission (comma-
                        separated). Currently visual_model, motion_model, and
                        terrain are supported. Usage:
                        [instance=]argument=value...
    --strace            strace the ArduPilot binary
    --model=MODEL       Override simulation model to use
    --use-dir=USE_DIR   Store SITL state and output in named directory
    --no-mavproxy       Don't launch MAVProxy
    --fresh-params      Generate and use local parameter help XML
    --mcast             Use multicasting at default 239.255.145.50:14550
    --udp               Use UDP on 127.0.0.1:5760
    --osd               Enable SITL OSD
    --osdmsp            Enable SITL OSD using MSP
    --tonealarm         Enable SITL ToneAlarm
    --rgbled            Enable SITL RGBLed
    --add-param-file=ADD_PARAM_FILE
                        Add a parameters file to use
    --no-extra-ports    Disable setup of UDP 14550 and 14551 output
    -Z SWARM, --swarm=SWARM
                        Specify path of swarminit.txt for shifting spawn
                        location
    --auto-offset-line=AUTO_OFFSET_LINE
                        Argument of form  BEARING,DISTANCE.  When running
                        multiple instances, form a line along bearing with an
                        interval of DISTANCE
    --flash-storage     use flash storage emulation
    --fram-storage      use fram storage emulation
    --disable-ekf2      disable EKF2 in build
    --disable-ekf3      disable EKF3 in build
    --start-time=START_TIME
                        specify simulation start time in format YYYY-MM-DD-
                        HH:MM in your local time zone
    --sysid=SYSID       Set SYSID_THISMAV
    --postype-single    force single precision postype_t
    --ekf-double        use double precision in EKF
    --ekf-single        use single precision in EKF
    --slave=SLAVE       Set the number of JSON slave
    --auto-sysid        Set SYSID_THISMAV based upon instance number
    --sim-address=SIM_ADDRESS
                        IP address of the simulator. Defaults to localhost

  Compatibility MAVProxy options (consider using --mavproxy-args instead):
    --out=OUT           create an additional mavlink output
    --map               load map module on startup
    --console           load console module on startup
    --aircraft=AIRCRAFT
                        store state and logs in named directory
    --moddebug=MODDEBUG
                        mavproxy module debug
    --no-rcin           disable mavproxy rcin

  Completion helpers:
    --list-vehicle      List the vehicles
    --list-frame=LIST_FRAME
                        List the vehicle frames

eeprom.bin in the starting directory contains the parameters for your
simulated vehicle. Always start from the same directory. It is recommended
that you start in the main vehicle directory for the vehicle you are
simulating, for example, start in the ArduPlane directory to simulate
ArduPlane
