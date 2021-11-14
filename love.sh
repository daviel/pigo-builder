#!/bin/bash
# requirements for love
apt-get install build-essential autotools-dev automake libtool \
pkg-config libfreetype6-dev libluajit-5.1-dev libphysfs-dev \
libopenal-dev libogg-dev libvorbis-dev libmodplug-dev libmpg123-dev \
libtheora-dev -y

git clone https://github.com/love2d/love
cd /love
export ACLOCAL_PATH=/usr/local/share/aclocal/
./platform/unix/automagic
./configure
make -j $(nproc)

strip /love/src/.libs/love
strip /love/src/.libs/liblove-11.3.so

cp /love/src/.libs/love /output/
cp /love/src/.libs/liblove-11.3.so /output/

# cleanup
#rm -rf /love
