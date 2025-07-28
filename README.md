# Various *OpenWRT* packages of *Graphite*-related projects

> [!IMPORTANT]
> The only supported *OpenWRT* version is **24.10**.

## Packages

* [go-graphite/go-carbon](https://github.com/go-graphite/go-carbon)
* [go-graphite/carbonapi](https://github.com/go-graphite/carbonapi)
* [grobian/carbon-c-relay](https://github.com/grobian/carbon-c-relay)

  Three variants:

  * `carbon-c-relay-full`
  * `carbon-c-relay-nossl`
  * **`carbon-c-relay-tiny`**

* [grafana/carbon-relay-ng](https://github.com/grafana/carbon-relay-ng)
* [atlassian/gostatsd](https://github.com/atlassian/gostatsd)
* `collectd-statsd`

  *StatsD* server created from *CollectD* with *StatD* plugin.
  For simple scenarios this approach may be more efficient than heavy `gostatsd` daemon.

* [grafana/grafana](https://github.com/grafana/grafana)

  Package name: `grafana-bin`.

  [Grafana](https://grafana.com) packages are created from the official [Standalone Linux Binaries](https://grafana.com/grafana/download?edition=oss&platform=linux)
  for a limited number of CPU architectures.
  
  <details>
  <summary>Supported CPU architectures</summary>

  | *OpenWRT* architecture | Binaries architecture |
  | ---------------------- | --------------------- |
  | `x86_64` | `amd64` |
  | `aarch64_generic` | `aarch64` |
  | `aarch64_cortex-a53` | `aarch64` |
  | `aarch64_cortex-a72` | `aarch64` |
  | `aarch64_cortex-a76` | `aarch64` |
  | `arm_cortex-a7` | `armv7` |
  | `arm_cortex-a7_neon-vfpv4` | `armv7` |
  | `arm_cortex-a8_vfpv3` | `armv7` |
  | `arm_cortex-a9` | `armv7` |
  | `arm_cortex-a9_neon` | `armv7` |
  | `arm_cortex-a9_vfpv3-d16` | `armv7` |
  | `arm_cortex-a15_neon-vfpv4` | `armv7` |
  | `arm_arm1176jzf-s_vfp` | `armv6` |
  
  </details>

* [influxdata/telegraf](https://github.com/influxdata/telegraf)

  Package name: `telegraf-bin`.

  [Telegraf](https://influxdata.com/telegraf) packages are created from the official *Linux Binaries*
  for a limited number of CPU architectures.

  <details>
  <summary>Supported CPU architectures</summary>

  | *OpenWRT* atchitecture | Binaries architecture |
  | ---------------------- | --------------------- |
  | `x86_64` | `amd64` |
  | `aarch64_generic` | `arm64` |
  | `aarch64_cortex-a53` | `arm64` |
  | `aarch64_cortex-a72` | `arm64` |
  | `aarch64_cortex-a76` | `arm64` |
  | `arm_cortex-a7` | `armhf` |
  | `arm_cortex-a7_neon-vfpv4` | `armhf` |
  | `arm_cortex-a8_vfpv3` | `armhf` |
  | `arm_cortex-a9` | `armhf` |
  | `arm_cortex-a9_neon` | `armhf` |
  | `arm_cortex-a9_vfpv3-d16` | `armhf` |
  | `arm_cortex-a15_neon-vfpv4` | `armhf` |
  | `arm_arm1176jzf-s_vfp` | `armel` |
  | `mipsel_mips32` | `mipsel` |
  | `riscv64_riscv64` | `riscv64` |

  </details>

## Installation

### Download and run [installation script](https://github.com/RoEdAl/graphite-feed/blob/main/openwrt/graphite-feed.sh)

```sh
wget -qO - https://roedal.github.io/graphite-feed/graphite-feed.sh | sh
```

### Update package list

```sh
$ opkg update
Downloading https://roedal.github.io/graphite-feed/aarch64_generic/graphite/Packages.gz
Updated list of available packages in /var/opkg-lists/graphite
Downloading https://roedal.github.io/graphite-feed/aarch64_generic/graphite/Packages.sig
Signature check passed.
⋯
```

### Install required package(s)

```sh
opkg install go-carbon carbonapi carbon-c-relay-tiny
```

> [!IMPORTANT]
> All services are **disabled** by default.
> To enable specific service change `enabled` flag to `1` in relevant configuration file from `/etc/config` directory.
>
> ```sh
> uci set go-carbon.main.enabled=1
> uci commit
> service go-carbon restart
> ```
