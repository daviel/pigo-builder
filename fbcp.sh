#!/bin/bash
apt remove cmake cmake-data -y
apt install cmake=3.13.4-1 cmake-data=3.13.4-1 -y

git clone https://github.com/juj/fbcp-ili9341 /fbcp
cd /fbcp
mkdir -p build
cd build

cat > /proc/cpuinfo<< EOF
processor	: 0
model name	: ARMv6-compatible processor rev 7 (v6l)
BogoMIPS	: 1691.53
Features	: half thumb fastmult vfp edsp java tls
CPU implementer	: 0x41
CPU architecture: 7
CPU variant	: 0x0
CPU part	: 0xb76
CPU revision	: 7

Hardware	: BCM2835
Revision	: 9000c1
Serial		: 00000000b664b4c4
Model		: Raspberry Pi Zero W Rev 1.1
EOF

cmake -DILI9341=ON -DGPIO_TFT_DATA_CONTROL=6 -DGPIO_TFT_RESET_PIN=5 \
-DGPIO_TFT_BACKLIGHT=13 -DSPI_BUS_CLOCK_DIVISOR=8 -DDISPLAY_ROTATE_180_DEGREES=ON \
-DBACKLIGHT_CONTROL=ON -DARMV6Z=ON -DSINGLE_CORE_BOARD=ON -DSTATISTICS=0 ..

make -j $(nproc)

strip /fbcp/build/fbcp-ili9341
cp /fbcp/build/fbcp-ili9341 /output/

# cleanup
rm -rf /fbcp
