#!/bin/sh
exec dpkg-buildpackage --build=binary -us -uc
