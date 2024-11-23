# openwrt-builder
Builder for OpenWrt in Docker container and GitHub Actions.
## Run container
To run container with predefined settings use
```
make run
```
It will download build dependencies, mount `/rom` folder and `git clone` OpenWrt repo.   
## Build
Build system requires that it's commands are not executed by root, so `builder` user are created.   
Build root can be found at `/home/builder/openwrt`.
```
make download -j$(nproc)
make tools/install -j$(nproc)
make toolchain/install -j$(nproc)
make -j$(nproc)
```
## Copy image to mounted folder
```
cp bin/targets/ rom -r
```
## Xiaomi AX3000T
```
echo "CONFIG_TARGET_mediatek=y\n" > .config
echo "CONFIG_TARGET_mediatek_filogic=y\n" >> .config
echo "CONFIG_TARGET_mediatek_filogic_DEVICE_xiaomi_mi-router-ax3000t=y\n" >> .config
echo "CONFIG_PACKAGE_dnsmasq=m\n" >> .config
echo "CONFIG_PACKAGE_dnsmasq-full=y\n" >> .config
echo "CONFIG_PACKAGE_luci=y\n" >> .config
echo "CONFIG_PACKAGE_luci-app-passwall2=y\n" >> .config

make defconfig
```
## Install passwall2
```
echo "src-git pw2 https://github.com/xiaorouji/openwrt-passwall2" >> feeds.conf.default
echo "src-git imm https://github.com/immortalwrt/packages" >> feeds.conf.default
./scripts/feeds update -a && \
./scripts/feeds install -a
```
## Golang build fixup (mac os)
```
make menuconfig
CONFIG_GOLANG_EXTERNAL_BOOTSTRAP_ROOT="/usr/bin/go"
```