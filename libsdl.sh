#!/bin/bash
# requirements for SDL
apt install libxext-dev -y

git clone https://github.com/libsdl-org/SDL
sed -i 's/DISPMANX_FLAGS_ALPHA_FIXED_ALL_PIXELS/DISPMANX_FLAGS_ALPHA_FROM_SOURCE/g' /SDL/src/video/raspberry/SDL_rpivideo.c
cd SDL
mkdir -p build
cd build
../configure
make -j $(nproc)
cd SDL/build
make install

strip /usr/local/lib/libSDL2-2.0.so.0
cp /usr/local/lib/libSDL2-2.0.so.0 /output/

# cleanup
rm -rf /SDL
