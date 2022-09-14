# lede-openwrt-builder
Builder for OpenWrt fork https://github.com/coolsnowwolf/lede in Docker container.   
## Run container
To run container with predefined settings use
```
make run
```
It will download build dependencies, mount `/rom` folder and `git clone` lede repo.   
## Build
Build system requires that it's commands are not executed by root, so `builder` user are created.   
Build root can be found at `/home/builder/lede`.   
After container is started you can configure build options via
```
make menuconfig
```
After that use (`j` is the number of threads)
```mk
make download -j8
make V=s -j8

# Copy image to mounted folder
cp bin/targets/ rom -r
```
## Xiaomi Redmi Router AC2100
There's a release image with ROM for this device (it can be updated in a case of new major changes in source repo).   
Changes can be seen here: https://github.com/coolsnowwolf/lede/tree/master/target/linux/ramips/mt7621

OpenWrt device wiki: https://openwrt.org/toh/xiaomi/xiaomi_redmi_router_ac2100

Configuration
```
 - MediaTek Ralink MIPS
 - MT7621 based boards
 - Xiaomi Redmi Router AC2100
```
