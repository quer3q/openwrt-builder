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
## Debug build process
```
make V=s 2>&1 | tee build.log | grep -i -E "^make.*(error|[12345]...Entering dir)"
```
## Install passwall2
```
echo "src-git pw2 https://github.com/xiaorouji/openwrt-passwall2" >> feeds.conf.default
echo "src-git imm https://github.com/immortalwrt/packages;branch-name" >> feeds.conf.default
./scripts/feeds update -a && \
./scripts/feeds install -a
```
## Golang build fixup (mac os)
```
make menuconfig
CONFIG_GOLANG_EXTERNAL_BOOTSTRAP_ROOT="/usr/bin/go"
```