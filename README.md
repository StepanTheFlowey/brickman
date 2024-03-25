brickman
========

The ev3dev Brick Manager.
Customised by my own opinion:

* Open Roberta Lab removed.
* UI Design changed.
* All LEDs are now set to show disk activity by default.
* Compilation with LTO enabled.

Hacking
-------

Get the code:

* Clone the repo:

        git clone --recurse-submodules --depth=1 https://github.com/StepanTheFlowey/brickman.git

Building:

*   Install [Docker] and QEMU setup:

        sudo apt install docker-buildx-plugin docker-ce qemu-user-static qemu-system-arm binfmt-support

*   Install build dependecies:

        sudo apt-add-repository ppa:ev3dev/tools
        sudo apt update
        sudo apt install fakeroot cmake valac netpbm libgudev-1.0-dev libgirepository1.0-dev libev3devkit-dev build-essential debhelper devscripts

*   Build the code by running:

        sudo dpkg-buildpackage

*   Copy the result *.deb to EV3 and install it:

        sudo dpkg -i *.deb

[Docker]: https://www.docker.com/
