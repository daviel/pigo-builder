#!/bin/bash
START_TIME=`date +%s`

echo "- - - - - - - - - - - - - - - -"
echo "- - - Building - - -"
echo "- - - - - - - - - - - - - - - -"

# host needs: apt install qemu-user-static debootstrap -y
debootstrap --no-check-gpg --foreign --arch=armhf bullseye ./raspbian http://archive.raspbian.org/raspbian
cp /usr/bin/qemu-arm-static ./raspbian/usr/bin
mkdir -p build
mkdir -p ./raspbian/output

# configure chroot environment
cp ./config.sh ./raspbian/root/
chroot ./raspbian /root/config.sh

# fbcp
cp ./fbcp.sh ./raspbian/root/
chroot ./raspbian /root/fbcp.sh

# libSDL
cp ./libsdl.sh ./raspbian/root/
chroot ./raspbian /root/libsdl.sh

# love
cp ./love.sh ./raspbian/root/
chroot ./raspbian /root/love.sh

# nuklear
cp ./nuklear.sh ./raspbian/root/
chroot ./raspbian /root/nuklear.sh

# copy artifacts
cp ./raspbian/output/* build/


STOP_TIME=`date +%s`
RUNTIME=$((STOP_TIME-START_TIME))

echo "- - - - - - - - - - - - - - - -"
echo "- - - Time: $RUNTIME s - - -"
echo "- - - - - - - - - - - - - - - -"
