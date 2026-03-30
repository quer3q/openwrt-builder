# openwrt-builder
OpenWrt firmware builder using the official Image Builder via Docker and GitHub Actions.

## Supported devices

| Device | Workflow | Packages |
|--------|----------|----------|
| NanoPi R3S | `nanopi-r3s.yml` | LuCI, Passwall2, AdGuardHome, partition tools |
| Xiaomi AX3000T | `ax3000t-pw2.yml` | LuCI, Passwall2 |
| Cudy WR3000E | `wr3000e.yml` | LuCI |

## GitHub Actions
All workflows use the OpenWrt Image Builder — no full source compilation required. Trigger any workflow manually via `workflow_dispatch`. Built images are uploaded as artifacts and published as GitHub releases.

## Local build (Docker)
`Dockerfile.imagebuilder` replicates the NanoPi R3S GitHub Actions build locally.

```
docker build -f Dockerfile.imagebuilder -t openwrt-imagebuilder .
```

Output images will be in `/home/builder/imagebuilder/bin/targets/` inside the container.

## Legacy source build
`Dockerfile` and `Makefile` provide a full source build environment for manual compilation.

```
make run
```

This starts a container with the OpenWrt source tree at `/home/builder/openwrt`. From there:

```
make menuconfig
make download -j$(nproc)
make -j$(nproc)
```

### Golang build fixup (macOS)
```
make menuconfig
CONFIG_GOLANG_EXTERNAL_BOOTSTRAP_ROOT="/usr/bin/go"
```
