#!/bin/bash
# requirements for SDL
apt install libxext-dev -y
apt install libraspberrypi-dev/oldstable libraspberrypi/oldstable -y

git clone https://github.com/libsdl-org/SDL
sed -i 's/DISPMANX_FLAGS_ALPHA_FIXED_ALL_PIXELS/DISPMANX_FLAGS_ALPHA_FROM_SOURCE/g' /SDL/src/video/raspberry/SDL_rpivideo.c
cd SDL
mkdir -p build
cd build
../configure
make -j $(nproc)
cd SDL/build
make install

cp /usr/local/lib/libSDL2* /output/
strip /output/libSDL2*

# cleanup
rm -rf /SDL
