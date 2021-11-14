#!/bin/bash
apt remove cmake cmake-data -y
apt install cmake=3.13.4-1 cmake-data=3.13.4-1 luajit libluajit-5.1-dev -y

git clone --recursive https://github.com/keharriso/love-nuklear.git /nuklear
cd /nuklear
mkdir -p build
cd build

cmake -DCMAKE_BUILD_TYPE=Release ..

make -j $(nproc)

strip /nuklear/build/nuklear.so
cp /nuklear/build/nuklear.so /output/

# cleanup
rm -rf /nuklear
