brickman
========

The ev3dev Brick Manager.

Issues
------

Please report issues or feature requests at https://github.com/ev3dev/ev3dev/issues

Hacking
-------

Get the code:

* Clone of the brickman repo.

        git clone --recurse-submodules https://github.com/ev3dev/brickman

To build for the EV3:

*   Install [Docker] (requires Linux/macOS 10.10.3+/Window 10 Pro)
*   Install QEMU (Linux only)

        sudo apt install qemu-user-static

*   In the source code directory, run the Docker setup script

        ./docker/setup.sh $ARCH

    Where `$ARCH` is `armel` (or `armhf` if you are building for RPi
    or BeagleBone).  Output will be saved to a `build-$ARCH` directory.

*   Build the code by running...

        docker exec --tty brickman_armel make install

*   Copy the contents of `build-$ARCH/dist/` to the EV3 and run it.

[Docker]: https://www.docker.com/

To build the desktop test (makes UI development much faster), in a regular terminal,
not in Docker:

*   Install build dependencies:

        sudo apt-add-repository ppa:ev3dev/tools
        sudo apt update
        sudo apt install devscripts equivs
        sudo mk-build-deps --install debian/control

* Then...

        cmake -P setup.cmake
        make -C build
        make -C build run
